extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@onready var tile_maps: Node2D = $TileMaps

func _ready() -> void:
  # player.tscn ships its own Camera2D. It enters the tree before this one, so
  # it claims `current` and the house camera is never used. Shut it off first.
  var player_cam := player.get_node_or_null("Camera2D") as Camera2D
  if player_cam:
    player_cam.enabled = false

  var rect := _house_rect()
  camera.position_smoothing_enabled = false
  camera.global_position = rect.get_center()
  camera.zoom = _zoom_to_fit(rect)
  camera.make_current()

# gets total area of house scene
func _house_rect() -> Rect2:
  var rect := Rect2()
  var found := false
  for child in tile_maps.get_children():
    var layer := child as TileMapLayer
    if layer == null or layer.tile_set == null:
      continue
    var used: Rect2i = layer.get_used_rect()
    if used.size == Vector2i.ZERO:
      continue
    var tile_size := Vector2(layer.tile_set.tile_size)
    var top_left: Vector2 = layer.to_global(Vector2(used.position) * tile_size)
    var size: Vector2 = Vector2(used.size) * tile_size * layer.global_scale
    var world := Rect2(top_left, size)
    rect = world if not found else rect.merge(world)
    found = true
  return rect

func _zoom_to_fit(rect: Rect2) -> Vector2:
  if rect.size.x <= 0.0 or rect.size.y <= 0.0:
    return Vector2.ONE
  var vp: Vector2 = get_viewport_rect().size
  var factor: float = minf(vp.x / rect.size.x, vp.y / rect.size.y)
  return Vector2(factor, factor)
