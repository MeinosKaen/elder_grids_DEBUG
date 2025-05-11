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

func left_click(pos):#Function that simulates Left Click
	var press = InputEventMouseButton.new()
	press.set_button_index(MOUSE_BUTTON_LEFT)
	press.set_position(pos)
	press.set_pressed(true)
	Input.parse_input_event(press)
	var release = InputEventMouseButton.new()
	release.set_button_index(MOUSE_BUTTON_LEFT)
	release.set_position(pos)
	release.set_pressed(false)
	Input.parse_input_event(release)

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
