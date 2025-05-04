@icon("res://icons/02_NPCBehaviour.jpg")
class_name NPCBehaviour extends Node2D

var npc : NPC


func _ready() -> void:
	var p = get_parent()
	if p is NPC:
		npc = p as NPC
		npc.do_behaviour_enabled.connect(start)

func start() -> void:
	pass
