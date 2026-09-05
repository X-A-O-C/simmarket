class_name Player extends CharacterBody2D

var input_direction: Vector2 = Vector2.ZERO
enum dir {UP, DOWN, LEFT, RIGHT}
var current_dir: int = dir.LEFT
@export var speed: float = 150.0
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var hour_label: RichTextLabel = $CanvasLayer/RichTextLabel
@onready var canvas_modulate: day_and_night_cycle = get_tree().get_first_node_in_group("interacton_mg").get_node("CanvasModulate")
@warning_ignore("narrowing_conversion")
@onready var mnoznik: int = (canvas_modulate.day_lenght_orginal + canvas_modulate.no_change_time_orginal + canvas_modulate.night_lenght_orginal) / 24
var can_move: bool = true
func _ready() -> void:
  hour_label.text = str(24 - (int(ceil((canvas_modulate.day_lenght + canvas_modulate.no_change_time + canvas_modulate.night_lenght) / mnoznik))))

func _physics_process(_delta: float) -> void:
  get_input()
  update_animation()
  update_hour()
  move_and_slide() 

func get_input():
  if not can_move:
    return
  input_direction = Input.get_vector("left", "right", "up", "down")
  velocity = input_direction * speed
    
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

func update_hour():
  hour_label.text = str(24 - (int(ceil((canvas_modulate.day_lenght + canvas_modulate.no_change_time + canvas_modulate.night_lenght) / mnoznik))))
