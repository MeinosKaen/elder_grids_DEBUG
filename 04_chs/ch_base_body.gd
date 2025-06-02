class_name Player extends CharacterBody2D

signal player_damaged(hurtbox:Hurtbox)

var car_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO

var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite2d : Sprite2D = $Sprite2D_Idle
@onready var StateMachine : PlayerStateMachine = $StateMachine
@onready var hitbox: Hitbox = $Interactions/Hitbox
@onready var game_time_timer: Timer = $game_time_timer
@onready var post_process_node: CanvasLayer = $PostProcess

signal DirectionChanged(new_direction:Vector2)

func _ready():
	PlayerManager.player = self
	StateMachine.Initialize(self)
	hitbox.Damaged.connect(TakeDamage)
	game_time_timer.start()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass
	
func _process(delta):
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(delta: float):
	if not PlayerStats.player_context == "Exploration":
		return
	move_and_slide()

func _input(event: InputEvent) -> void:
	if PlayerStats.player_context == "Exploration":
		if event.is_action_pressed("menu"):
			PlayerStats.player_context = "Main Menu"
			var current_scene = self.get_parent()
			var main_menu = PlayerManager.MAINMENU.instantiate()
			current_scene.add_child(main_menu)

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	var direction_id : int = int(round((direction+car_direction*0.1).angle()/TAU*DIR_4.size()))
	var new_direction = DIR_4[direction_id]
	if new_direction == car_direction:
		return false
	car_direction = new_direction
	DirectionChanged.emit(new_direction)
	return true
	
func UpdatedAnimation(state : String) -> void:
	if not PlayerStats.player_context == "Exploration":
		return
	animation_player.play(state + "_" + AnimDirection())
	pass
	
func AnimDirection():
	if car_direction == Vector2.DOWN:
		return "down"
	elif car_direction == Vector2.UP:
		return "up"
	elif car_direction == Vector2.LEFT:
		return "left"
	elif car_direction == Vector2.RIGHT:
		return "right"

func TakeDamage(hurtbox:Hurtbox) -> void:
	if invulnerable:
		return
	UpdateHP(-hurtbox.damage)
	if PlayerStats.current_hp <= 0:
		PlayerStats.current_hp = 0
		UpdateHP(50)
		player_damaged.emit(hurtbox)
	else:
		player_damaged.emit(hurtbox)
	pass
func UpdateHP(delta:int) -> void:
	PlayerStats.current_hp = clampi(PlayerStats.current_hp + delta, 0, PlayerStats.max_hp)
	pass
func MakeInvulnerable(_duration:float=1.0) -> void:
	invulnerable = true
	hitbox.monitoring = false
	await get_tree().create_timer(_duration)
	invulnerable = false
	hitbox.monitoring = true
	pass


func _on_game_time_timer_timeout() -> void:
	PlayerManager.game_time_seconds += 1
	if PlayerManager.game_time_seconds == 60:
		PlayerManager.game_time_minutes += 1
		PlayerManager.game_time_seconds = 0
	if PlayerManager.game_time_minutes == 60:
		PlayerManager.game_time_hours += 1
		PlayerManager.game_time_minutes = 0

func _on_dialogic_signal(command:String):
	if command == "mc_turnleft":
		animation_player.play("idle_left")
	if command == "mc_turnup":
		animation_player.play("idle_up")
	if command == "mc_turnright":
		animation_player.play("idle_right")
	if command == "mc_turndown":
		animation_player.play("idle_down")
	return
