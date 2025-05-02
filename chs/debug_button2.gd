extends Button

@onready var character_body = $"../.."
@onready var state_machine = $"../../../../StateMachine"

func _process(delta: float) -> void:
	text = "PLAYER POS = " + str(PlayerManager.player.global_position)
	#text = str(character_body.direction)
	
