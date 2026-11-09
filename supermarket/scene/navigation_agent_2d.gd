extends NavigationAgent2D

@export var speed: float = 150.0

@onready var npc: CharacterBody2D = get_parent()
@onready var points: Array = []
@onready var dic: Dictionary = get_parent().shopping_list

func _ready() -> void:
  await get_tree().physics_frame
  dic = get_parent().shopping_list
  points = get_tree().get_first_node_in_group("NavigationGroup").get_children()

func _physics_process(_delta: float) -> void:
  if is_navigation_finished():
    go_to_a_point_from_shopping_list()
      
      

  var next_pos: Vector2 = get_next_path_position()
  
  var direction: Vector2 = (next_pos - npc.global_position).normalized()
  
  npc.velocity = direction * speed
  npc.move_and_slide()
  

func go_to_a_point_from_shopping_list() -> void:
  if points.is_empty(): 
    return   
  print(dic)
  if dic == {}:
    if is_navigation_finished():
      if target_position == points[-1].global_position:
        print("Koniec")
        target_position = points[-2].global_position
        return
      elif target_position != points[-2].global_position:
        print("DAE")
        target_position = points[-1].global_position
      else:
        get_parent().queue_free()
        return
    return
  var k = dic.keys().pick_random()
  if dic[k] >= 1:
    get_parent().shopping_list[k] -= 1
    var random_marker = points.pick_random()
    target_position = random_marker.global_position
  if dic[k] == 0:
    dic.erase(k)
