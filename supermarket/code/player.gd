extends CharacterBody2D

@export var speed: float = 150.0
@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = Vector2.ZERO
	if Input.is_key_pressed(KEY_A):
		input_direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		input_direction.x += 1
	if Input.is_key_pressed(KEY_W):
		input_direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		input_direction.y += 1
		
			
	velocity = input_direction.normalized() * speed
	_update_animation(input_direction)
	move_and_slide() 
# Called when the node enters the scene tree for the first time.
func _update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		sprite.stop()
		return
	if direction.y < 0:
		sprite.play('walk_up')
	if direction.y > 0:
		sprite.play('walk_down')
	if direction.x < 0:
		sprite.play('walk_left')
	if direction.x > 0:
		sprite.play('walk_right')
'''	if direction.y < 0 and Input.is_action_just_pressed('E'):
		sprite.play('activation_up')
	if direction.y > 0 and Input.is_action_just_pressed('Activate'):
		sprite.play('activation_down')
	if direction.x < 0 and Input.is_action_just_pressed('Activate'):
		sprite.play('activation_left')
	if direction.x > 0 and Input.is_action_just_pressed('Activate'):
		sprite.play('activation_right')
	'''

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
