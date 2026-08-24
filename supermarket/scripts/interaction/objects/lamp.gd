extends Node2D

@export var ui_offset := Vector2(10, -10)

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var light_select: OptionButton = $CanvasLayer/LightSelect
@onready var warm_light: PointLight2D = $WarmLight
@onready var cold_light: PointLight2D = $ColdLight

func _ready():
  interaction_area.interact = Callable(self, "_on_interact")
  light_select.hide()
  light_select.item_selected.connect(_on_light_selected)
  _on_light_selected(light_select.selected)

func _on_interact():
  _update_ui_position()
  light_select.visible = not light_select.visible

func _on_light_selected(index: int) -> void:
  warm_light.enabled = index == 1
  cold_light.enabled = index == 2
  light_select.hide()

func _update_ui_position() -> void:
  light_select.position = get_global_transform_with_canvas().origin + ui_offset
