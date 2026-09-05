extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: Player = get_tree().get_first_node_in_group("player")
var is_currently_checkout: bool = false
func _ready():
  interaction_area.interact = Callable(self, "_on_interact")
func _on_interact():
  is_currently_checkout = !is_currently_checkout
  player.can_move = !player.can_move

func leaved_interaction(_body: Node2D):
  is_currently_checkout = false
  player.can_move = true
