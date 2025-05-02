class_name State_Idle extends State

@onready var walk_state : State = $"../Walk"

#What happens when Entering this State
func Enter() -> void:
	character.UpdatedAnimation("idle")
	pass
#What happens when Exiting this State
func Exit() -> void:
	pass
#What happens during the process update in this state
func Process(_delta: float) -> State:
	if character.direction != Vector2.ZERO:
		return walk_state
	character.velocity = Vector2.ZERO
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> State:
	return null
#What happens with inputs events in this state
func HandleInput(_event: InputEvent) -> State:
	return null
