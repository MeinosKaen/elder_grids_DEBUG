class_name Level extends Node2D

@export var BGM : AudioStreamOggVorbis = null
@export var BGS : AudioStreamOggVorbis = null

@export var Cutscene : DialogueResource = null

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	LevelManager.LevelLoadStarted.connect(_free_level)
	if BGM != null:
		AudioManager.play_music(BGM)
	if BGS != null:
		AudioManager.play_bgs(BGS)
	PlayerManager.cs_pos_1.x = $CS1_SENSEI_POS.global_position.x
	PlayerManager.cs_pos_1.y = $CS1_SENSEI_POS.global_position.y
	if Cutscene != null:
		PlayerManager.cutscene_walk(PlayerManager.player,PlayerManager.cs_pos_1)
		PlayerStats.DialogueFinished.connect(dialogue_finished)
		PlayerStats.player_context = "Cutscene"
		PlayerManager.dialogue_start(Cutscene)

func _free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()

func dialogue_finished() -> void:
	PlayerStats.player_context = "Exploration"
	PlayerStats.current_targetNPC = null
	pass
