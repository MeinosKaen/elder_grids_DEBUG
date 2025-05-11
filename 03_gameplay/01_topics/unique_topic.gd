@icon("res://icons/08_UniqueTopics.jpg")
class_name unique_topic extends Node

@export var topic_name : String = ""
@export_enum("Step One", "Step Two", "Step Three", "Step Four", "Step Five") var topic_step = "Step One"
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
	if topic_step == "Step One":
		var file: = FileAccess.open(step_one_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == "Step Two":
		var file: = FileAccess.open(step_two_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == "Step Three":
		var file: = FileAccess.open(step_three_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == "Step Four":
		var file: = FileAccess.open(step_four_text, FileAccess.READ)
		json.parse(file.get_line())	
	elif topic_step == "Step Five":
		var file: = FileAccess.open(step_five_text, FileAccess.READ)
		json.parse(file.get_line())	
	var current_description : String = json.get_data() as String
	topic_description = current_description
