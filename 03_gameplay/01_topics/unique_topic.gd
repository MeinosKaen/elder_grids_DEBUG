@icon("res://icons/08_UniqueTopics.jpg")
class_name unique_topic extends Node

@export var topic_name : String = ""
@export var topic_step : int = 1
@export_file("*.json") var step_one_text
@export_file("*.json") var step_two_text
@export_file("*.json") var step_three_text
@export_file("*.json") var step_four_text
@export_file("*.json") var step_five_text

var topic_description : String = ""

func _ready() -> void:
	update_description()
	pass
	
func update_description() -> void:
	var json := JSON.new()
	if topic_step == 1:
		var file: = FileAccess.open(step_one_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == 2:
		var file: = FileAccess.open(step_two_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == 3:
		var file: = FileAccess.open(step_three_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == 4:
		var file: = FileAccess.open(step_four_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == 5:
		var file: = FileAccess.open(step_five_text, FileAccess.READ)
		json.parse(file.get_line())	
	var current_description : String = json.get_data() as String
	topic_description = current_description
