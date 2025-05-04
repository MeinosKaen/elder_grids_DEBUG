class_name EnemyStateWander extends EnemyState

@export var anim_name : String = "walk"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.6
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction : Vector2

#What happens when Initializing this State
func Init() -> void:
	pass
#What happens when the Enemy is Entering this State
func Enter() -> void:
	#print("Entering State "+str(self.name))
	_timer = randi_range(state_cycles_min, state_cycles_max)
	var rand = randi_range(0,3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.SetDirection(_direction)
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
