extends Control

@onready var mini_button_01 = preload("res://minimap_button_base.tscn")

func _ready() -> void:
	var times_duplicate = 0
	var current_row = 0
	var current_column = 0
	while times_duplicate < 64:
		var new_button = mini_button_01.instantiate()
		new_button.global_position.x = current_row * 48
		new_button.global_position.y = current_column * 48
		add_child(new_button)
		current_row += 1
		if current_row == 8:
			current_row = 0
			current_column += 1
		times_duplicate += 1
