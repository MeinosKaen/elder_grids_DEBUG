extends Node

const PLAYER = preload("res://04_chs/player/ch_player.tscn")
const MAINMENU = preload("res://06_GUI/menus/main_menu.tscn")
var player : Player
var player_spawned : bool = false
var last_npc_touched : Node2D = null

##Time Measurement Variables
var game_time_seconds : int = 0
var game_time_hours : int = 0
var game_time_minutes : int = 0


func _ready() -> void:
	add_player_instance()

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)
