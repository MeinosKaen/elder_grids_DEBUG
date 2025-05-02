extends Node

signal TileMapBoundsChanged(bounds:Array[Vector2])
signal LevelLoadStarted
signal LevelLoaded

var current_tilemap_bounds : Array[Vector2]
var target_transition : String
var position_offset : Vector2

func _ready() -> void:
	await get_tree().process_frame
	LevelLoaded.emit()

func ChangeTilemapBounds(bounds:Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
	
func LoadNewLevel(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2
) -> void:
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	await MapTransition.fade_out()
	LevelLoadStarted.emit()
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(level_path)
	await MapTransition.fade_in()
	get_tree().paused = false
	await get_tree().process_frame
	LevelLoaded.emit()
	pass
