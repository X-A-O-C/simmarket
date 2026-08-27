extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"
@export var label_offset: Vector2 = Vector2(0, -48)

var interact: Callable = func():
  pass

func _on_body_entered(_body: Node2D):
  InteractionManager.register_area(self)

func _on_body_exited(_body: Node2D) -> void:
  InteractionManager.unregister_area(self)
