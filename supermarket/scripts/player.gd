extends CharacterBody2D

var input_direction: Vector2 = Vector2.ZERO
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
  if input_direction.y < 0:
    sprite.play('walk_up')
  if input_direction.y > 0:
    sprite.play('walk_down')
  if input_direction.x < 0:
    sprite.play('walk_left')
  if input_direction.x > 0:
    sprite.play('walk_right')
'''	if input_direction.y < 0 and Input.is_action_just_pressed('E'):
    sprite.play('activation_up')
  if input_direction.y > 0 and Input.is_action_just_pressed('Activate'):
    sprite.play('activation_down')
  if input_direction.x < 0 and Input.is_action_just_pressed('Activate'):
    sprite.play('activation_left')
  if input_direction.x > 0 and Input.is_action_just_pressed('Activate'):
    sprite.play('activation_right')
  '''

func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass
