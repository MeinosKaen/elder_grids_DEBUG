class_name ch_enemy extends CharacterBody2D

signal DirectionChanged(new_direction:Vector2)
signal enemy_damaged(hurtbox : Hurtbox)
signal enemy_destroyed(hurtbox : Hurtbox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

var car_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

func _ready():
	state_machine.Initialize(self)
	player = PlayerManager.player
	hitbox.Damaged.connect(TakeDamage)
	pass
func _physics_process(_delta):
	move_and_slide()
	
func SetDirection(_new_direction:Vector2) -> bool:
	direction = _new_direction
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

func TakeDamage(hurtbox : Hurtbox) -> void:
	if invulnerable:
		return
	hp -= hurtbox.damage
	if hp <= 0:
		hp = 0
		enemy_destroyed.emit(hurtbox)
	else:
		enemy_damaged.emit(hurtbox)
