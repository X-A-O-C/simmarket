extends CanvasModulate

# time is in seconds

@export_category("Times (time is in seconds)")

@export var day_lenght: float = 120.0
var day_lenght_orginal: float = 120.0

@export var no_change_time: float = 10.0
var no_change_time_orginal: float = 10.0

@export var night_lenght: float = 30.0 
var night_lenght_orginal: float = 30.0

@export_category("Colors")

@export var org_color: Color = Color(1,1,1)
@export var target_color: Color = Color(0.3, 0.3, 0.3)

func _ready() -> void:
  color = org_color
  day_lenght_orginal = day_lenght
  night_lenght_orginal = night_lenght
  no_change_time = no_change_time_orginal
    
func _process(delta: float) -> void:
  coundown(delta)

func coundown(delta) -> void:
  
  if day_lenght != 0:
    day_lenght = max(0, day_lenght - delta)
    var lerp_weight_formula: float = clamp((day_lenght_orginal - day_lenght) / day_lenght_orginal, 0.0, 1.0)
    color = lerp(org_color, target_color, lerp_weight_formula)
  elif no_change_time != 0:
    no_change_time = max(0, no_change_time - delta)
  else:
    night_lenght = max(0, night_lenght - delta)
    var lerp_weight_formula: float = clamp((night_lenght_orginal - night_lenght) / night_lenght_orginal, 0.0, 1.0)
    color = lerp(target_color, org_color, lerp_weight_formula)
  if night_lenght == 0:
    day_lenght = day_lenght_orginal
    night_lenght = night_lenght_orginal
    no_change_time = no_change_time_orginal
    
  
