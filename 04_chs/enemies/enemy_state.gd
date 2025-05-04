class_name EnemyState extends Node

var enemy : ch_enemy
var state_machine : EnemyStateMachine

#What happens when Initializing this State
func Init() -> void:
	pass
#What happens when the Enemy is Entering this State
func Enter() -> void:
	pass
#What happens when the Enemy is  Exiting this State
func Exit() -> void:
	pass
#What happens during the process update in this state
func Process(_delta: float) -> EnemyState:
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
