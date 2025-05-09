@tool
@icon("res://icons/01_NPC.jpg")
class_name NPCRandomizer extends CharacterBody2D

signal do_behaviour_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"
var do_behaviour: bool = true

@export var npc_resource : NPCResource : set = SetNPCResource
@export var dialogue_script : DialogicTimeline
@export_enum("Children", "Future1", "Future2", "Future3", "Modern1", "Modern2") var npc_group : String = "None"
@export_enum("up", "left", "right", "down", "None") var fixed_position : String = "None"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	SetupNPC()
	if Engine.is_editor_hint():
		return
	do_behaviour_enabled.emit()
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
	if npc_group == "Modern1":
		var sprite_pool : Array = ["res://04_chs/npcs/spritesheets/fbb_modern1/biz_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/black_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/blue_woman.png", "res://04_chs/npcs/spritesheets/fbb_modern1/cow_boy.png", "res://04_chs/npcs/spritesheets/fbb_modern1/dreads_girl.png", "res://04_chs/npcs/spritesheets/fbb_modern1/fbb_modern1.png", "res://04_chs/npcs/spritesheets/fbb_modern1/glasses_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/muscle_man.png"]
		var sprite_index = randi_range(0,7)
		var new_sprite = load(sprite_pool[sprite_index])
		print(new_sprite)
		sprite.texture = new_sprite
	if fixed_position != "None":
		direction_name = fixed_position
		UpdateAnimation()
	pass

func SetNPCResource(_npc:NPCResource) -> void:
	npc_resource = _npc
	SetupNPC()
