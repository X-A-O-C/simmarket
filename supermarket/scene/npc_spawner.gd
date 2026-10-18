extends Node2D

const NPC_SCENE = preload("res://scene/npc.tscn")
@onready var player: Player = $"../Player"

func _process(delta: float) -> void:
  if self.get_child_count() == 1:
    return
  if int(player.hour_label.text) == 8:
    await get_tree().create_timer(10).timeout
    var npc_instance = NPC_SCENE.instantiate()
    add_child(npc_instance)
