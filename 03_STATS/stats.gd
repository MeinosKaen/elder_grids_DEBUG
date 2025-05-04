class_name Stats extends Node

@onready var player_hud: CanvasLayer = $"../playerHUD"
@onready var hitbox: Hitbox = $"../Interactions/Hitbox"

@export var max_hp : int = 100
@export var max_stm : int = 100
@export var max_mp : int = 100
var current_hp = 100
var current_stm = 75
var current_mp = 35
var recharge_clicks = 0

func _ready() -> void:
	hitbox.Damaged.connect(UpdateStats)

func _process(delta: float) -> void:
	recharge_clicks += 1
	if recharge_clicks == 60:
		if current_hp < max_hp:
			current_hp += 1
		if current_stm < max_stm:
			current_stm += 1
		if current_mp < max_mp:
			current_mp += 1
		recharge_clicks = 0
		player_hud.UpdateStatsHUD()
	else:
		pass

func UpdateStats(_hurtbox:Hurtbox) -> void:
	player_hud.UpdateStatsHUD()
