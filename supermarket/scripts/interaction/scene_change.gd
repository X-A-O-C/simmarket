extends Area2D

@export_file("*.tscn") var target_scene: String = "res://scene/house.tscn"

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
  interaction_area.interact = Callable(self, "_on_interact")
  
func _on_interact():
  _change_scene()
  print("scene interact!")

func _change_scene():
  if target_scene != "":
    get_tree().change_scene_to_file(target_scene)
