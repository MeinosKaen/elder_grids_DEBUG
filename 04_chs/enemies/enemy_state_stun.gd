class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 300.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

#What happens when Initializing this State
func Init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass
#What happens when the Enemy is Entering this State
func Enter() -> void:
	enemy.invulnerable = true
	#print("Entering State "+str(self.name))
	_animation_finished = false
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdatedAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
#What happens when the Enemy is  Exiting this State
func Exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
#What happens during the process update in this state
func Process(_delta: float) -> EnemyState:
	if _animation_finished == true:
		print("Returning to Idle.")
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> EnemyState:
	return null

func _on_enemy_damaged(hurtbox : Hurtbox) -> void:
	_damage_position = hurtbox.global_position
	state_machine.ChangeState(self)
	
func _on_animation_finished(_a:String) -> void:
	print("Animation Finished Detected.")
	_animation_finished = true
