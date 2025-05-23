class_name Level extends Node2D

@export var BGM : AudioStreamOggVorbis = null
@export var BGS : AudioStreamOggVorbis = null

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	LevelManager.LevelLoadStarted.connect(_free_level)
	if BGM != null:
		AudioManager.play_music(BGM)
	if BGS != null:
		AudioManager.play_bgs(BGS)

func _free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()
