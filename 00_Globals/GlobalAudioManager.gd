extends Node

var music_audio_player_count : int = 2
var current_music_player : int = 0
var music_players : Array[AudioStreamPlayer] = []
var music_bus : String = "bgm_bus"
var music_fade_duration : float = 0.5

var bgs_audio_player_count : int = 2
var current_bgs_player : int = 0
var bgs_players : Array[AudioStreamPlayer] = []
var bgs_bus : String = "bgs_bus"
var bgs_fade_duration : float = 1.0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in music_audio_player_count:
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.bus = music_bus
		music_players.append(audio_player)
		audio_player.volume_db = -40
	for i in bgs_audio_player_count:
		var bgs_audio_player = AudioStreamPlayer.new()
		add_child(bgs_audio_player)
		bgs_audio_player.bus = bgs_bus
		bgs_players.append(bgs_audio_player)
		bgs_audio_player.volume_db = -40


func play_music(_stream:AudioStream) -> void:
	if _stream == music_players[current_music_player].stream:
		return
	
	current_music_player += 1
	if current_music_player > 1:
		current_music_player = 0
	
	var current_player : AudioStreamPlayer = music_players[current_music_player]
	current_player.stream = _stream
	play_and_fade_in(current_player)
	
	var old_player = music_players[1]
	if current_music_player == 1:
		old_player = music_players[0]
	fade_out_and_stop(old_player)

func play_bgs(_stream:AudioStream) -> void:
	if _stream == bgs_players[current_bgs_player].stream:
		return
	
	current_bgs_player += 1
	if current_bgs_player > 1:
		current_bgs_player = 0
	
	var current_player : AudioStreamPlayer = bgs_players[current_bgs_player]
	current_player.stream = _stream
	play_and_fade_in_bgs(current_player)
	
	var old_player = bgs_players[1]
	if current_bgs_player == 1:
		old_player = bgs_players[0]
	fade_out_and_stop_bgs(old_player)

func play_and_fade_in(audio_player:AudioStreamPlayer) -> void:
	audio_player.play(0)
	var tween : Tween = create_tween()
	tween.tween_property(audio_player, 'volume_db', 0, music_fade_duration)
	pass

func fade_out_and_stop(audio_player:AudioStreamPlayer) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(audio_player, 'volume_db', -40, music_fade_duration)
	await tween.finished
	audio_player.stop()
	pass
func play_and_fade_in_bgs(audio_player:AudioStreamPlayer) -> void:
	audio_player.play(0)
	var tween : Tween = create_tween()
	tween.tween_property(audio_player, 'volume_db', 0, bgs_fade_duration)
	pass

func fade_out_and_stop_bgs(audio_player:AudioStreamPlayer) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(audio_player, 'volume_db', -40, bgs_fade_duration)
	await tween.finished
	audio_player.stop()
	pass
