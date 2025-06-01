@icon("res://icons/battle_icons/03_battle_skill.jpg")
class_name BattleSkill extends Node

@export var battleskill_name : String = ""
@export var battleskill_power : int = 1
@export var battleskill_icon : Texture2D = null

@export_enum("Melee Damage", "Ranged Damage", "Magic Damage", "Recovery Only", "Debuff Only", "Buff Only", "Passive") var battleskill_type : String = "Melee Damage"
@export_enum("Fire", "Water", "Earth", "Wind", "Melee", "Ranged", "Lightning", "Ice", "Rot", "Growth", 
"Gravity", "Levitation", "Explosion", "Healing", "Ruin", "Psychosis") var battleskill_element : String = "None"
@export_enum("Single Enemy", "Single Ally", "All Enemies", "All Allies", "Everyone") var battleskill_target : String = "Single Enemy"
@export var status_effect = null#: StatusEffect
