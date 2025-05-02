extends Button

func _ready():
	self.text = str(int(global_position.x / 48)) + "/" + str(int(global_position.y / 48))
