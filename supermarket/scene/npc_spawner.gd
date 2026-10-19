extends Node2D

const NPC_SCENE = preload("res://scene/npc.tscn")
@export var npc_spawn_intervall: float = 5.0
@export var max_npc_amount: int = 8
@onready var player: Player = $"../Player"
var can_spawn_an_npc = true
func _process(_delta: float) -> void:
    spawn_npc()

func spawn_npc():
    if can_spawn_an_npc:
      if int(player.hour_label.text) in range(8,16):
        if self.get_child_count() >= max_npc_amount:
          return
        can_spawn_an_npc = false
        var npc_instance = NPC_SCENE.instantiate()
        add_child(npc_instance)
        await get_tree().create_timer(npc_spawn_intervall).timeout
        can_spawn_an_npc = true
    else:
      return
