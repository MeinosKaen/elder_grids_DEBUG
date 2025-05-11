@tool
@icon("res://icons/01_NPC.jpg")
class_name NPCRandomizer extends CharacterBody2D

signal do_behaviour_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"
var do_behaviour: bool = true

@export var npc_resource : NPCResource : set = SetNPCResource
@export var dialogue_script : DialogicTimeline = null
@export_enum("Children", "Trad1_men", "Trad1_women", "Trad2_men", "Trad2_women", "Modern1", "Modern2") var npc_group : String = "None"
@export_enum("up", "left", "right", "down", "None") var fixed_position : String = "None"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var talkative : bool = true
var npc_weapons : float = 1.0
var npc_health : float = 1.0
### ARCANE
var npc_monsters : float = 1.0
var npc_literature : float = 1.0
### VITALITY
var npc_nature : float = 1.0
var npc_romance : float = 1.0
### ALACRITY
var npc_subterfuge : float = 1.0
var npc_commerce : float = 1.0
### FORTUNE
var npc_games : float = 1.0
var npc_mysteries : float = 1.0

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
	#elif npc_group == "Children":
	#	sprite_pool = []
	var sprite_pool : Array
	if npc_group == "Modern1":
		sprite_pool = ["res://04_chs/npcs/spritesheets/fbb_modern1/biz_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/black_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/blonde_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/blue_woman.png", "res://04_chs/npcs/spritesheets/fbb_modern1/cow_boy.png", "res://04_chs/npcs/spritesheets/fbb_modern1/dreads_girl.png", "res://04_chs/npcs/spritesheets/fbb_modern1/glasses_man.png", "res://04_chs/npcs/spritesheets/fbb_modern1/muscle_man.png"]
	elif npc_group == "Children":
		sprite_pool = ["res://04_chs/npcs/spritesheets/fbb_children/blonde_child.png", "res://04_chs/npcs/spritesheets/fbb_children/blue_child.png", "res://04_chs/npcs/spritesheets/fbb_children/bowl_child.png", "res://04_chs/npcs/spritesheets/fbb_children/brunette_child.png", "res://04_chs/npcs/spritesheets/fbb_children/cobalt_child.png", "res://04_chs/npcs/spritesheets/fbb_children/ginger_child.png", "res://04_chs/npcs/spritesheets/fbb_children/green_child.png", "res://04_chs/npcs/spritesheets/fbb_children/red_child.png"]
	elif npc_group == "Trad1_men":
		sprite_pool = ["res://04_chs/npcs/spritesheets/ffb_trad1/farmer_man.png", "res://04_chs/npcs/spritesheets/ffb_trad1/gnsweater_body.png", "res://04_chs/npcs/spritesheets/ffb_trad1/headband_guy.png", "res://04_chs/npcs/spritesheets/ffb_trad1/ljacket_guy.png", "res://04_chs/npcs/spritesheets/ffb_trad1/moustache_guy.png", "res://04_chs/npcs/spritesheets/ffb_trad1/rjacket_guy.png", "res://04_chs/npcs/spritesheets/ffb_trad1/slickback_guy.png", "res://04_chs/npcs/spritesheets/ffb_trad1/suspenders_guy.png"]
	var sprite_index = randi_range(0,7)
	var new_sprite = load(sprite_pool[sprite_index])
	sprite.texture = new_sprite
	if fixed_position != "None":
		direction_name = fixed_position
		UpdateAnimation()
	pass

func SetNPCResource(_npc:NPCResource) -> void:
	npc_resource = _npc
	npc_weapons = npc_resource.npc_weapons
	npc_health = npc_resource.npc_health
	npc_monsters = npc_resource.npc_monsters
	npc_literature = npc_resource.npc_literature
	npc_nature = npc_resource.npc_nature
	npc_romance = npc_resource.npc_romance
	npc_subterfuge = npc_resource.npc_subterfuge
	npc_commerce = npc_resource.npc_commerce
	npc_games = npc_resource.npc_games
	npc_mysteries = npc_resource.npc_mysteries
	#SetupNPC()
