extends Node2D

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
  active_areas.push_back(area)
  
func unregister_area(area: InteractionArea):
  var index = active_areas.find(area)
  if index != -1:
    active_areas.remove_at(index)
    
func _process(_delta):
  if active_areas.size() > 0 && can_interact:
    active_areas.sort_custom(_sort_by_distance_to_player)
    var area = active_areas[0]
    label.text = base_text + area.action_name

    # fix scale for when camera zoom is 2 (house scene)
    var zoom: Vector2 = _camera_zoom()
    label.scale = Vector2.ONE / zoom

    # label_offset is authored in screen pixels, so divide by zoom to land in world units.
    label.global_position = area.global_position + area.label_offset / zoom
    label.global_position.x -= label.size.x * label.scale.x / 2
    label.show()
  else:
    label.hide()

func _camera_zoom() -> Vector2:
  var cam := get_viewport().get_camera_2d()
  return cam.zoom if cam else Vector2.ONE
    
func _sort_by_distance_to_player(area1, area2) -> bool:
  player = get_tree().get_first_node_in_group("player")
  
  var area1_to_player = player.global_position.distance_to(area1.global_position)
  var area2_to_player = player.global_position.distance_to(area2.global_position)
  return area1_to_player < area2_to_player
  
func _input(event):
  if event.is_action_pressed("interact") && can_interact:
    if active_areas.size() > 0:
      can_interact = false
      label.hide()
      await active_areas[0].interact.call()
      can_interact = true
