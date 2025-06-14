extends Node

const PLAYER = preload("res://04_chs/player/ch_player.tscn")
const MAINMENU = preload("res://06_GUI/menus/main_menu.tscn")
var player : Player
var player_spawned : bool = false
var last_npc_touched : Node2D = null

#Cutscene Variables and Signals
var cs_pos_1 : Vector2 = Vector2.ZERO
var cs_pos_2 : Vector2 = Vector2.ZERO
var cs_pos_3 : Vector2 = Vector2.ZERO

signal cutscene_signal()
@onready var balloon = preload("res://06_GUI/base_balloon.tscn")

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

func dialogue_start(resource: DialogueResource, title: String = "", extra_game_states : Array =[]):
	PlayerStats.player_context = "Cutscene"
	var balloon_scene = balloon.instantiate()
	DialogueManager.get_current_scene.call().add_child(balloon_scene)
	balloon_scene.start(resource,title,extra_game_states)
	DialogueManager.dialogue_started.emit(resource)
	
	return balloon_scene

func dialogue_finished():
	PlayerStats.player_context = "Exploration"

func cutscene_walk(walker,target):
	if target == Vector2.ZERO:
		return
	walker.StateMachine.ChangeState(walker.walk_state)
	var direction = walker.global_position.direction_to(target)
	walker.direction = direction
	walker.velocity = walker.walk_state.move_speed * direction
	walker.SetDirection()
	walker.UpdatedAnimation("walk")
	pass
