extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player

# Tiles are 16px; the tilemaps span x -4..4 and y -11..-2.
const HOUSE_RECT := Rect2(-64, -176, 144, 160)

func _ready() -> void:
  var player_cam := player.get_node_or_null("Camera2D") as Camera2D
  if player_cam:
    player_cam.enabled = false

  camera.position_smoothing_enabled = false
  camera.global_position = HOUSE_RECT.get_center()
  camera.zoom = _zoom_to_fit(HOUSE_RECT)
  camera.make_current()

func _zoom_to_fit(rect: Rect2) -> Vector2:
  var vp: Vector2 = get_viewport_rect().size
  var factor: float = minf(vp.x / rect.size.x, vp.y / rect.size.y)
  return Vector2(factor, factor)
