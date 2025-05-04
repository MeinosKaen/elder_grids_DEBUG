class_name State extends Node

static var character : Player
static var state_machine: PlayerStateMachine

func _ready():
	pass
#What happens when Initializing this State
func Init() -> void:
	pass	
#What happens when Entering this State
func Enter() -> void:
	pass
#What happens when Exiting this State
func Exit() -> void:
	pass
#What happens during the process update in this state
func Process(_delta: float) -> State:
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> State:
	return null
#What happens with inputs events in this state
func HandleInput(_event: InputEvent) -> State:
	return null
