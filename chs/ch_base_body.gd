class_name ch_base extends CharacterBody2D

var car_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite2d : Sprite2D = $Sprite2D_Idle
@onready var StateMachine : PlayerStateMachine = $"../StateMachine"

func _ready():
	StateMachine.Initialize(self)
	pass
	
func _process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	pass

func _physics_process(delta: float):
	move_and_slide()

func SetDirection() -> bool:
	var new_direction : Vector2 = car_direction
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	if direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if new_direction == car_direction:
		return false
	car_direction = new_direction
	return true
	
func UpdatedAnimation(state : String) -> void:
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
