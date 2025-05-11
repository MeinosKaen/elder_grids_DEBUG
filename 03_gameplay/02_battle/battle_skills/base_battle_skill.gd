@icon("res://icons/battle_icons/03_battle_skill.jpg")
class_name BattleSkill extends Node

@export var battleskill_name : String = ""
@export var battleskill_power : int = 1
@export var battleskill_icon : Texture2D = null

@export_enum("Physical Damage", "Ranged Damage", "Magic Damage", "Recovery Only", "Debuff Only", "Buff Only") var battleskill_type : String = "Physical Damage"
@export_enum("Fire", "Ice", "Lightning") var battleskill_element : String = "Fire"
