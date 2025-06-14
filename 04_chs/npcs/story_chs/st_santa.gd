@tool
@icon("res://icons/05_NPCUnique.jpg")
class_name NPC_Santa extends CharacterBody2D

signal do_behaviour_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"
var do_behaviour: bool = true

@export var npc_resource : NPCResource : set = SetNPCResource
@export var dialogue_script : DialogueResource = null
@export_enum("up", "left", "right", "down", "None") var fixed_position : String = "None"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var cs_pos_1 : Vector2 = Vector2.ZERO
@export var cs_pos_2 : Vector2 = Vector2.ZERO
@export var cs_pos_3 : Vector2 = Vector2.ZERO

func _ready() -> void:
	SetupNPC()
	if Engine.is_editor_hint():
		return
	do_behaviour_enabled.emit()
	PlayerManager.cutscene_signal.connect(_on_cutscene_signal)
	pass

func _physics_process(delta: float) -> void:
	#move_and_slide()
	pass

func UpdateAnimation() -> void:
	#print(state+"_"+direction_name)
	animation_player.play(state+"_"+direction_name)

func UpdateDirection(target_position:Vector2) -> void:
	direction = global_position.direction_to(target_position)
	UpdateDirectionName()

func UpdateDirectionName() -> void:
	var threshold : float = 0.45
	#print("Dir.X:"+str(direction.x))
	#print("Dir.Y:"+str(+direction.y))
	if direction.y < -threshold:
		direction_name = "up"
	elif direction.y > threshold:
		direction_name = "down"
	elif direction.x > threshold:
		direction_name = "right"
	elif direction.x < -threshold:
		direction_name = "left"
	#print("New Direction Name is: "+direction_name)
		
func SetupNPC() -> void:
	#if npc_resource:
	#elif npc_group == "Children":
	#	sprite_pool = []
	if fixed_position != "None":
		direction_name = fixed_position
		UpdateAnimation()
	pass

func SetNPCResource(_npc:NPCResource) -> void:
	npc_resource = _npc
	SetupNPC()

func _on_cutscene_signal(command:String):
	if PlayerStats.player_context != "Cutscene":
		return
	if command == "santa_turnleft":
		animation_player.play(state+"_left")
	if command == "santa_turnup":
		animation_player.play(state+"_up")
	if command == "santa_turnright":
		animation_player.play(state+"_right")
	if command == "santa_turndown":
		animation_player.play(state+"_down")
	return
