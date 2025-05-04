extends Button

func _process(delta: float) -> void:
	text = "PLAYER POS = " + str(int(PlayerManager.player.global_position.x / 48)) + "/" + str(int(PlayerManager.player.global_position.y / 48))
	#text = str(character_body.direction)
	
