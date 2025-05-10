extends Control

@onready var weapons_button: Button = $topics_container/weapons_button
@onready var health_button: Button = $topics_container/health_button
@onready var monsters_button: Button = $topics_container/monsters_button
@onready var literature_button: Button = $topics_container/literature_button
@onready var nature_button: Button = $topics_container/nature_button
@onready var romance_button: Button = $topics_container/romance_button
@onready var subterfuge_button: Button = $topics_container/subterfuge_button
@onready var commerce_button: Button = $topics_container/commerce_button
@onready var games_button: Button = $topics_container/games_button
@onready var mysteries_button: Button = $topics_container/mysteries_button

func _ready() -> void:
	weapons_button.text = "WEAPONS - " + str(int(PlayerStats.weapons))
	health_button.text = "HEALTH - " + str(int(PlayerStats.health))
	monsters_button.text = "MONSTERS - " + str(int(PlayerStats.monsters))
	literature_button.text = "LITERATURE - " + str(int(PlayerStats.literature))
	nature_button.text = "NATURE - " + str(int(PlayerStats.nature))
	romance_button.text = "ROMANCE - " + str(int(PlayerStats.romance))
	subterfuge_button.text = "SUBTERFUGE - " + str(int(PlayerStats.subterfuge))
	commerce_button.text = "COMMERCE - " + str(int(PlayerStats.commerce))
	games_button.text = "GAMES - " + str(int(PlayerStats.games))
	mysteries_button.text = "MYSTERIES - " + str(int(PlayerStats.mysteries))
