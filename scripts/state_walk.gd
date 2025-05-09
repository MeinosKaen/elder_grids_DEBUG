class_name State_Walk extends State

@export var move_speed : float = 200.0
@onready var idle_state : State = $"../Idle"
@onready var attack_state : State = $"../Attack"

#What happens when Entering this State
func Enter() -> void:
	character.UpdatedAnimation("walk")
	pass
#What happens when Exiting this State
func Exit() -> void:
	pass
#What happens during the process update in this state
func Process(_delta: float) -> State:
	if character.direction == Vector2.ZERO:
		return idle_state
	character.velocity = character.direction * move_speed
	if character.SetDirection():
		character.UpdatedAnimation("walk")
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> State:
	return null
#What happens with inputs events in this state
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		if PlayerStats.current_stm > 5:
			return attack_state
		else:
			return null
	return null
