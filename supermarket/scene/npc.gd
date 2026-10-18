extends Node2D

@onready var hair_front: Sprite2D = $hairs/front
@onready var hair_back: Sprite2D = $hairs/back
@onready var hair_left: Sprite2D = $hairs/left
@onready var hair_right: Sprite2D = $hairs/right
@onready var eyes: Sprite2D = $eyes
@onready var head: Sprite2D = $head
@onready var body: Sprite2D = $body
@onready var hand_left: Sprite2D = $hand_left
@onready var hand_right: Sprite2D = $hand_right
@onready var legs: Sprite2D = $legs
@onready var boots: Sprite2D = $boots



func _ready() -> void:
  generate_object(hair_front, Vector2(16,11), [2,1])
  generate_object(head, Vector2(12,14), [2,1])
  generate_object(eyes, Vector2(8,5), [1,3])
  generate_object(body, Vector2(20,24), [2,1])
  generate_object(hand_left, Vector2(4,4), [2,1])
  hand_right.region_rect = hand_left.region_rect
  generate_object(legs, Vector2(14,0), [2,0])
  generate_object(boots, Vector2(0,4), [0,3])


  
func generate_object(object: Sprite2D, spacing: Vector2, max_random: Array) ->  void:
    var position: Vector2 = Vector2(randi_range(0,max_random[0]) * spacing.x,  randi_range(0,max_random[1]) * spacing.y)
    object.region_rect = Rect2(position, object.region_rect.size)

  
  
