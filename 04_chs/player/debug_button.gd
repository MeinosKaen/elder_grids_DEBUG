extends Button

@onready var state_machine = $"../../../../StateMachine"

func _process(delta: float) -> void:
	text = "STATE = " + state_machine.current_state.name
	#text = str(character_body.direction)
	
