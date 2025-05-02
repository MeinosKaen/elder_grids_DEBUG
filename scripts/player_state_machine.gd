class_name PlayerStateMachine extends Node

var states : Array[State]
var prev_state : State
var current_state : State

func _ready():
	#print("Disabling...")
	#process_mode = Node.PROCESS_MODE_DISABLED [THIS DISABLES THE STATE MACHINE AND RENDERS IT INOPERATIVE]
	pass
func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))
	pass
func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))
	pass
func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize( _character : ch_base) -> void:
	states = []
	for c in get_children():
		if c is State:
			states.append(c)
			print(str(c.name))
	
	if states.size() > 0:
		states[0].character = _character
		print(str(states[0].character.name))
		ChangeState( states[0] )

func ChangeState( new_state : State) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.Exit()
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
