extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved


var current_save : Dictionary ={
	scene_path = "",
	player_x = 0,
	player_y = 0,
	player_info = {
		first_name = "",
		last_name = "",
		background = "",
		player_context = "",
		current_money = 1,
	},
	game_time_variables = {
		game_time_seconds = 0,
		game_time_hours = 0,
		game_time_minutes = 0,
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
}

func save_game() -> void:
	save_path_base_time()
	save_lvling_attributes()
	save_topics()
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	print("Game Saved")
	pass

func load_game() -> void:
	var file: = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())	
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	LevelManager.LoadNewLevel(current_save.scene_path, "", Vector2.ZERO)
	await LevelManager.LevelLoadStarted
	
	PlayerManager.set_player_position(Vector2(current_save.player_x,current_save.player_y))
	load_base_time()
	load_lvling_attributes()
	load_topics()
	await LevelManager.LevelLoaded
	game_loaded.emit()
	print("Game Loaded")
	pass

func save_path_base_time() -> void:
	var path : String = ""
	for n in get_tree().root.get_children():
		if n is Level:
			path = n.scene_file_path
	current_save.scene_path = path
	var current_player = PlayerManager.player
	current_save.player_x = current_player.global_position.x
	current_save.player_y = current_player.global_position.y
	current_save.player_info.first_name = PlayerStats.first_name
	current_save.player_info.last_name = PlayerStats.last_name
	current_save.player_info.background = PlayerStats.background
	current_save.player_info.player_context = PlayerStats.player_context
	current_save.player_info.current_money = PlayerStats.current_money
	current_save.game_time_variables.game_time_seconds = PlayerManager.game_time_seconds
	current_save.game_time_variables.game_time_hours = PlayerManager.game_time_hours
	current_save.game_time_variables.game_time_minutes = PlayerManager.game_time_minutes

func save_lvling_attributes() -> void:
	current_save.player_lvling_info.lvl = PlayerStats.lvl
	current_save.player_lvling_info.current_exp = PlayerStats.current_exp
	current_save.player_lvling_info.current_exp_threshold = PlayerStats.current_exp_threshold
	current_save.player_attributes.vigor = PlayerStats.vigor
	current_save.player_attributes.arcane = PlayerStats.arcane
	current_save.player_attributes.vitality = PlayerStats.vitality
	current_save.player_attributes.alacrity = PlayerStats.alacrity
	current_save.player_attributes.fortune = PlayerStats.fortune
	current_save.player_attributes.max_hp = PlayerStats.max_hp
	current_save.player_attributes.max_mp = PlayerStats.max_mp
	current_save.player_attributes.max_stm = PlayerStats.max_stm
	current_save.player_attributes.current_hp = PlayerStats.current_hp
	current_save.player_attributes.current_mp = PlayerStats.current_mp
	current_save.player_attributes.current_stm = PlayerStats.current_stm

func save_topics() -> void:
	current_save.player_gen_topics.weapons = PlayerStats.weapons
	current_save.player_gen_topics.health = PlayerStats.health
	current_save.player_gen_topics.monsters = PlayerStats.monsters
	current_save.player_gen_topics.literature = PlayerStats.literature
	current_save.player_gen_topics.nature = PlayerStats.nature
	current_save.player_gen_topics.romance = PlayerStats.romance
	current_save.player_gen_topics.subterfuge = PlayerStats.subterfuge
	current_save.player_gen_topics.commerce = PlayerStats.commerce
	current_save.player_gen_topics.games = PlayerStats.games
	current_save.player_gen_topics.mysteries = PlayerStats.mysteries
	current_save.player_unique_topics = PlayerStats.unique_topics

func load_base_time() -> void:
	PlayerStats.first_name = current_save.player_info.first_name
	PlayerStats.last_name = current_save.player_info.last_name
	PlayerStats.background = current_save.player_info.background
	#PlayerStats.player_context = current_save.player_info.player_context (THIS STUCKS THE PLAYER FOR NOW BUT USEFUL LATER)
	PlayerStats.current_money = current_save.player_info.current_money
	PlayerManager.game_time_seconds = current_save.game_time_variables.game_time_seconds
	PlayerManager.game_time_hours = current_save.game_time_variables.game_time_hours
	PlayerManager.game_time_minutes = current_save.game_time_variables.game_time_minutes

func load_lvling_attributes() -> void:
	PlayerStats.lvl = current_save.player_lvling_info.lvl
	PlayerStats.current_exp = current_save.player_lvling_info.current_exp
	PlayerStats.current_exp_threshold = current_save.player_lvling_info.current_exp_threshold
	PlayerStats.vigor = current_save.player_attributes.vigor
	PlayerStats.arcane = current_save.player_attributes.arcane
	PlayerStats.vitality = current_save.player_attributes.vitality
	PlayerStats.alacrity = current_save.player_attributes.alacrity
	PlayerStats.fortune = current_save.player_attributes.fortune
	PlayerStats.max_hp = current_save.player_attributes.max_hp
	PlayerStats.max_mp = current_save.player_attributes.max_mp
	PlayerStats.max_stm = current_save.player_attributes.max_stm
	PlayerStats.current_hp = current_save.player_attributes.current_hp
	PlayerStats.current_mp = current_save.player_attributes.current_mp
	PlayerStats.current_stm = current_save.player_attributes.current_stm

func load_topics() -> void:
	PlayerStats.weapons = current_save.player_gen_topics.weapons
	PlayerStats.health = current_save.player_gen_topics.health
	PlayerStats.monsters = current_save.player_gen_topics.monsters
	PlayerStats.literature = current_save.player_gen_topics.literature
	PlayerStats.nature = current_save.player_gen_topics.nature
	PlayerStats.romance = current_save.player_gen_topics.romance
	PlayerStats.subterfuge = current_save.player_gen_topics.subterfuge
	PlayerStats.commerce = current_save.player_gen_topics.commerce
	PlayerStats.games = current_save.player_gen_topics.games
	PlayerStats.mysteries = current_save.player_gen_topics.mysteries
