extends Node

const SAVE_PATH = "user://save_game.dat"

var game_data = {
  "currency": 50.0
}

func _ready() -> void:
  load_game()

func save_game() -> void:
  var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
  if file:
    file.store_var(game_data)
    file.close()
    print("saved game")

func load_game() -> void:
  if not FileAccess.file_exists(SAVE_PATH):
    print("no save file exists")
    return 
    
  var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
  if file:
    var loaded_data = file.get_var()
    file.close()
    if loaded_data is Dictionary:
      game_data = loaded_data
      print("game loading")
