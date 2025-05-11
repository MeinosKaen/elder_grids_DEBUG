@icon("res://icons/battle_icons/01_battler_ally.jpg")
class_name Battler extends Node

@export var battler_name : String = ""
@export var battler_lvl : int = 1
@export var battler_portrait : Texture2D = null

@export_group("Base")
@export var battler_hp : int = 1
@export var battler_max_hp : int = 1
@export var battler_mp : int = 1
@export var battler_max_mp : int = 1

@export_group("Attributes")
@export var battler_vigor : int = 1
@export var battler_arcane : int = 1
@export var battler_vitality : int = 1
@export var battler_alacrity : int = 1
@export var battler_fortune : int = 1

@export_group("Battle Skills")
@export var battler_attack : BattleSkill = null
@export var battler_skill_1 : BattleSkill = null
@export var battler_skill_2 : BattleSkill = null
@export var battler_skill_3 : BattleSkill = null
@export var battler_skill_4 : BattleSkill = null
@export var battler_skill_5 : BattleSkill = null
@export var battler_skill_6 : BattleSkill = null
@export var battler_skill_7 : BattleSkill = null
@export var battler_skill_8 : BattleSkill = null
@export var battler_defend : BattleSkill = null
