class_name EnemyStateIdle extends EnemyState

@export var anim_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var next_state : EnemyState

var _timer : float = 0.0

#What happens when Initializing this State
func Init() -> void:
	pass
#What happens when the Enemy is Entering this State
func Enter() -> void:
	#print("Entering State "+str(self.name))
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.UpdatedAnimation(anim_name)
	pass
#What happens when the Enemy is  Exiting this State
func Exit() -> void:
	pass
#What happens during the process update in this state
func Process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
