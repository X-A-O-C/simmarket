extends Node2D

const HAIRS_RIGHT_TYPE_1 = preload("uid://dw3h0nclenul6")
const HAIRS_BACK_TYPE_1 = preload("uid://chlov3q334c3l")
const HAIRS_FRONT_TYPE_1 = preload("uid://bywkkfnrmvu76")
const HAIRS_LEFT_TYPE_1 = preload("uid://cpek36nmqt30")
const EYES = preload("uid://2l8vmq4evfks")
const HEADS = preload("uid://daoqqg0p2rr4m")

@onready var hair_front: Sprite2D = $hairs/front
@onready var hair_back: Sprite2D = $hairs/back
@onready var hair_left: Sprite2D = $hairs/left
@onready var hair_right: Sprite2D = $hairs/right
@onready var eyes: Sprite2D = $eyes
@onready var head: Sprite2D = $head

var body_parts: Dictionary = {
  
  "hair_right_1" = [],
  "hair_left_1" = [],
  "hair_front_1" = [],
  "hair_back_1" = [],
  
  "eyes" = [],
  "heads" = []
  
}



func _ready() -> void:
  body_parts["hair_right_1"] = slice_sheet(HAIRS_RIGHT_TYPE_1, [2, 3])
  body_parts["hair_left_1"] = slice_sheet(HAIRS_LEFT_TYPE_1, [2, 3])
  body_parts["hair_front_1"] = slice_sheet(HAIRS_FRONT_TYPE_1, [2, 3])
  body_parts["hair_back_1"] = slice_sheet(HAIRS_BACK_TYPE_1, [2, 3])
  body_parts["eyes"] = slice_sheet(EYES, [8, 4])
  body_parts["heads"] = slice_sheet(HEADS, [2, 3])

  hair_right.texture = body_parts["hair_right_1"][randi_range(1, body_parts["hair_right_1"].size() - 1)]
  hair_left.texture = body_parts["hair_left_1"][randi_range(1, body_parts["hair_left_1"].size() - 1)]
  hair_front.texture = body_parts["hair_front_1"][randi_range(1, body_parts["hair_front_1"].size() - 1)]
  hair_back.texture = body_parts["hair_back_1"][randi_range(1, body_parts["hair_back_1"].size() - 1)]
  eyes.texture = body_parts["eyes"][randi_range(1, body_parts["eyes"].size() - 1)]
  head.texture = body_parts["heads"][randi_range(1, body_parts["heads"].size() - 1)]
  

  
func slice_sheet(sheet: Texture2D, rows_and_cols: Array) -> Array[AtlasTexture]:
  var parts: Array[AtlasTexture] = []

  var rows: int = rows_and_cols[0]
  var cols: int = rows_and_cols[1]

  var img: Image = sheet.get_image()
  var frame_size := Vector2i(
    (img.get_width() + cols - 1) / cols,
    (img.get_height() + rows - 1) / rows
  )
  for y in rows:
    for x in cols:
      var frame_rect := Rect2i(x * frame_size.x, y * frame_size.y, frame_size.x, frame_size.y)
      var frame_img: Image = img.get_region(frame_rect)
      var used_rect: Rect2i = frame_img.get_used_rect()

      if used_rect.size.x == 0 or used_rect.size.y == 0:
        continue

      var part := AtlasTexture.new()
      part.atlas = sheet
      part.region = Rect2(frame_rect.position + used_rect.position, used_rect.size)
      part.margin = Rect2(used_rect.position, frame_size - used_rect.size)

      parts.append(part)
  return parts
