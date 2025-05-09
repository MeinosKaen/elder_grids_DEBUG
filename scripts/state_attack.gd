class_name State_Attack extends State

var attacking : bool = false

@onready var walk_state : State = $"../Walk"
@onready var idle_state : State = $"../Idle"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var audio_player : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurtbox: Hurtbox = $"../../Interactions/Hurtbox"
@onready var player_hud: CanvasLayer = $"../../playerHUD"

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var deceleration_speed : float = 5.0

#What happens when Entering this State
func Enter() -> void:
	character.UpdatedAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9,1.1)
	audio_player.play()
	attacking = true
	await get_tree().create_timer(0.075)
	PlayerStats.current_stm -= 8
	player_hud.UpdateStatsHUD()
	hurtbox.monitoring = true
	pass
#What happens when Exiting this State
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	hurtbox.monitoring = false
	pass
#What happens during the process update in this state
func Process(_delta: float) -> State:
	character.velocity -= character.velocity * deceleration_speed * _delta
	if attacking == false:
		if character.direction == Vector2.ZERO:
			return idle_state
		else:
			return walk_state
	return null
#What happens during the physics process update in this state
func Physics(_delta: float) -> State:
	return null
#What happens with inputs events in this state
func HandleInput(_event: InputEvent) -> State:
	return null

func EndAttack(_newAnimName:String) -> void:
	attacking = false
