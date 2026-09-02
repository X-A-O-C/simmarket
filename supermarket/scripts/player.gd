class_name Player extends CharacterBody2D

var input_direction: Vector2 = Vector2.ZERO
enum dir {UP, DOWN, LEFT, RIGHT}
var current_dir: int = dir.LEFT
@export var speed: float = 150.0
@onready var sprite: AnimatedSprite2D = $Sprite

func get_input():
  input_direction = Input.get_vector("left", "right", "up", "down")
  velocity = input_direction * speed
    
func _physics_process(_delta: float) -> void:
  get_input()
  update_animation()
  move_and_slide() 

func update_animation() -> void:
  if input_direction == Vector2.ZERO:
    sprite.stop()
    return
  if input_direction.x < 0:
    current_dir = dir.LEFT
    sprite.play('walk_left')
  elif input_direction.x > 0:
    current_dir = dir.RIGHT
    sprite.play("walk_right")
  elif input_direction.y < 0:
    current_dir = dir.UP
    sprite.play("walk_up")
  elif input_direction.y > 0:
    current_dir = dir.DOWN
    sprite.play('walk_down')
