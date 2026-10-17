extends Node2D

const HAIRS_RIGHT_TYPE_1 = preload("uid://dw3h0nclenul6")
const HAIRS_BACK_TYPE_1 = preload("uid://chlov3q334c3l")
const HAIRS_FRONT_TYPE_1 = preload("uid://bywkkfnrmvu76")
const HAIRS_LEFT_TYPE_1 = preload("uid://cpek36nmqt30")
const EYES = preload("uid://2l8vmq4evfks")
const HEADS = preload("uid://dob4nctff1vf3")

@onready var npc: Sprite2D = $npc

var body_parts: Dictionary = {
  
  "hair_right_1" = [],
  "hair_left_1" = [],
  "hair_front_1" = [],
  "hair_back_1" = [],
  
  "eyes" = [],
  "heads" = []
  
}



func _ready() -> void:
  body_parts["hair_right_1"] = slice_sheet(HAIRS_RIGHT_TYPE_1, Vector2i(13, 9))
  npc.texture = body_parts["hair_right_1"][randi_range(1,body_parts["hair_right_1"].size() - 1)]
  
func slice_sheet(sheet: Texture2D, frame_size: Vector2i) -> Array[AtlasTexture]:
  var parts: Array[AtlasTexture] = []
  
  @warning_ignore("integer_division")
  var rows: int = sheet.get_height() / frame_size.y
  @warning_ignore("integer_division")
  var cols: int = sheet.get_width() / frame_size.x
  
  for y in rows:
    for x in cols:
      var part = AtlasTexture.new()
      part.atlas = sheet
      part.region = Rect2(
        x * frame_size.x,
        y * frame_size.y,
        
        frame_size.x,
        frame_size.y
      )
      parts.append(part)
  return parts
