extends Control

@onready var minimap_square = preload("res://minimap_square.tscn")

func _ready():
	var times_duplicate = 0
	var current_row = 0
	var current_column = 0
	while times_duplicate < 120:
		var new_square = minimap_square.instantiate()
		new_square.global_position.x = current_row * 384
		new_square.global_position.y = current_column * 384
		add_child(new_square)
		current_row += 1
		if current_row == 15:
			current_row = 0
			current_column += 1
		times_duplicate += 1
