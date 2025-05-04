class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 10.0

var hurtbox : Hurtbox
var direction : Vector2

var next_state : State = null

@onready var idle_state : State = $"../Idle"
@onready var stats: Stats = $"../../Stats"

#What happens when Initializing this State
func Init() -> void:
	character.player_damaged.connect(PlayerDamaged)
	
#What happens when Entering this State
func Enter() -> void:
	character.animation_player.animation_finished.connect(AnimationFinished)
	direction = character.global_position.direction_to(hurtbox.global_position)
	character.velocity = direction * -knockback_speed
	character.SetDirection()
	character.UpdatedAnimation("stun")
	character.MakeInvulnerable(invulnerable_duration)
	pass
#What happens when Exiting this State
func Exit() -> void:
	next_state = null
	character.animation_player.animation_finished.disconnect(AnimationFinished)
	pass
#What happens during the process update in this state
func Process(_delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return next_state
#What happens during the physics process update in this state
func Physics(_delta: float) -> State:
	return null
#What happens with inputs events in this state
func HandleInput(_event: InputEvent) -> State:
	return null

func PlayerDamaged(_hurt_box:Hurtbox) -> void:
	hurtbox = _hurt_box
	state_machine.ChangeState(self)
func AnimationFinished(_a:String) -> void:
	next_state = idle_state
