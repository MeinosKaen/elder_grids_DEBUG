extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved


var current_save : Dictionary ={
	scene_path = "",
	player_info = {
		first_name = "",
		last_name = "",
		background = "",
		player_context = "",
		current_money = 1,
	},
	player_lvling_info = {
		lvl = 1,
		current_exp = 1,
		current_exp_threshold = 1,
	},
	player_attributes = {
		vigor = 1,
		arcane = 1,
		vitality = 1,
		alacrity = 1,
		fortune = 1,
		max_hp = 1,
		max_mp = 1,
		max_stm = 1,
		current_hp = 1,
		current_mp = 1,
		current_stm = 1,
	},
	player_gen_topics = {
		weapons = 1.0,
		health = 1.0,
		monsters = 1.0,
		literature = 1.0,
		nature = 1.0,
		romance = 1.0,
		subterfuge = 1.0,
		commerce = 1.0,
		games = 1.0,
		mysteries = 1.0,
	},
	player_unique_topics = [],
	game_time_variables = {
		game_time_seconds = 0,
		game_time_hours = 0,
		game_time_minutes = 0,
	},
}

func save_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	print("save_game")
	pass

func load_game() -> void:
	print("load_game")
	pass
