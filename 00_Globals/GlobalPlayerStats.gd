class_name GlobalPlayerStats extends Node
signal DialogueFinished
# Basic Info
var first_name : String = "Nanni"
var last_name : String = "Nella"
var background : String = "Tony Award Winner"
var player_context : String = "Exploration"
var current_money : int = 0

#LvLing Info
var lvl = 1
var current_exp = 0
var current_exp_threshold = 100

# Attributes
var vigor : int = 3
var arcane : int = 3
var vitality : int = 3
var alacrity : int = 3
var fortune : int = 3
var max_hp : int = 100
var max_mp : int = 100
var max_stm : int = 100
var current_hp : int = 70
var current_mp : int = 30
var current_stm : int = 15

## BG Quiz
var brawler_type : int = 0
var ranged_type : int = 0
var magician_type : int = 0
var gambler_type : int = 0
var tank_type : int = 0
var balanced_type : int = 0

# Topics
## General Topics
### VIGOR
var weapons : float = 1.0
var health : float = 1.0
### ARCANE
var monsters : float = 1.0
var literature : float = 1.0
### VITALITY
var nature : float = 1.0
var romance : float = 1.0
### ALACRITY
var subterfuge : float = 1.0
var commerce : float = 1.0
### FORTUNE
var games : float = 1.0
var mysteries : float = 1.0

# Unique Topics
var unique_topics : Array[unique_topic] = []

##Topic Variables
var current_targetNPC : Node = null

# Functions
## Attribute Functions
func starter_attributes():
	var type_list : Array = []
	type_list.append(brawler_type)
	type_list.append(ranged_type)
	type_list.append(magician_type)
	type_list.append(gambler_type)
	type_list.append(tank_type)
	type_list.append(balanced_type)
	if type_list.max() == brawler_type:
		vigor = 12
		arcane = 3
		vitality = 9
		alacrity = 3
		fortune = 3
	elif type_list.max() == ranged_type:
		vigor = 3
		arcane = 3
		vitality = 6
		alacrity = 12
		fortune = 6
	elif type_list.max() == magician_type:
		vigor = 3
		arcane = 12
		vitality = 6
		alacrity = 3
		fortune = 6
	elif type_list.max() == gambler_type:
		vigor = 3
		arcane = 3
		vitality = 3
		alacrity = 6
		fortune = 12
	elif type_list.max() == tank_type:
		vigor = 9
		arcane = 3
		vitality = 12
		alacrity = 3
		fortune = 3
	elif type_list.max() == balanced_type:
		vigor = 6
		arcane = 6
		vitality = 6
		alacrity = 6
		fortune = 6

func lvl_up_attributes(plus_vigor, plus_arcane, plus_vitality, plus_alacrity, plus_fortune):
	vigor += plus_vigor
	arcane += plus_arcane
	vitality += plus_vitality
	alacrity += plus_alacrity
	fortune += plus_fortune
func lvl_up_hp_mp():
	max_hp = (vigor * 10) + (vitality * 5)
	max_mp = (arcane * 10) + (vitality * 5)
	current_hp = max_hp
	current_mp = max_mp

## Topic Functions
func lvl_up_topic(topic,npc_level):
	topic += int(npc_level * 0.01)

func add_new_topic(topic):
	unique_topics.append(topic)

func lvl_up_unique_topic(topic):
	var lvling_topic = null
	lvling_topic = unique_topics.find(topic)
	lvling_topic.level +=1

func dialogue_is_finished():
	DialogueFinished.emit()
