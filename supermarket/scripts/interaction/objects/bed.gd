extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var canvas_modulate: day_and_night_cycle = get_tree().get_first_node_in_group("interacton_mg").get_node("CanvasModulate")

func _ready():
  interaction_area.interact = Callable(self, "_on_interact")
  
func _on_interact():
  if canvas_modulate.day_lenght == 0 and canvas_modulate.no_change_time == 0:
    canvas_modulate.night_lenght = 0
    
