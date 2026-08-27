@tool
extends Node2D


@export var radius: float = 48.0:
  set(value):
    radius = value
    queue_redraw()

@export var color: Color = Color("#ffb347"):
  set(value):
    color = value
    queue_redraw()

@export_range(0.0, 1.0, 0.01) var opacity: float = 0.35:
  set(value):
    opacity = value
    queue_redraw()

## 1 = hard-edged circle, higher = softer falloff.
@export_range(1, 16) var softness: int = 7:
  set(value):
    softness = value
    queue_redraw()

func _draw() -> void:
  for i in softness:
    var t: float = 1.0 - float(i) / softness
    draw_circle(Vector2.ZERO, radius * t, Color(color, opacity / softness))
