extends CanvasLayer

@onready var name_label: RichTextLabel = $NAME_LVL/name_label
@onready var current_lvl: RichTextLabel = $NAME_LVL/lvling_stuff/current_lvl
@onready var current_exp: RichTextLabel = $NAME_LVL/exp_stuff/current_exp

@onready var hp_bar: ProgressBar = $HP_MP_STM/HP_STUFF/HP_BAR
@onready var hp_text: RichTextLabel = $HP_MP_STM/HP_STUFF/HP_TEXT
@onready var stm_bar: ProgressBar = $HP_MP_STM/STM_STUFF/STM_BAR
@onready var stm_text: RichTextLabel = $HP_MP_STM/STM_STUFF/STM_TEXT
@onready var mp_bar: ProgressBar = $HP_MP_STM/MP_STUFF/MP_BAR
@onready var mp_text: RichTextLabel = $HP_MP_STM/MP_STUFF/MP_TEXT

@onready var vigor_value: RichTextLabel = $stats_container/vigor_box/vigor_value
@onready var arcane_value: RichTextLabel = $stats_container/arcane_box/arcane_value
@onready var vitality_value: RichTextLabel = $stats_container/vitality_box/vitality_value
@onready var alacrity_value: RichTextLabel = $stats_container/alacrity_box/alacrity_value
@onready var fortune_value: RichTextLabel = $stats_container/fortune_box/fortune_value

@onready var money_value: RichTextLabel = $MONEY_TIME/money_box/money_value
@onready var time_value: RichTextLabel = $MONEY_TIME/time_box/time_value

var submenu_up : bool = false
var current_submenu : String = "None"
@onready var topics_sub: Control = $Topics_Sub


func _ready() -> void:
	get_tree().paused = true
	refresh_values()

func _input(event: InputEvent) -> void:
	if PlayerStats.player_context == "Main Menu":
		if event.is_action_pressed("cancel"):
			PlayerStats.player_context = "Exploration"
			get_tree().paused = false
			self.queue_free()

func refresh_values() -> void:
	name_label.text = "[b]" + PlayerStats.first_name + " " + PlayerStats.last_name
	current_lvl.text = str(PlayerStats.lvl)
	current_exp.text = str(PlayerStats.current_exp) + "/" + str(PlayerStats.current_exp_threshold)
	#HP BAR VALUES
	hp_bar.max_value = PlayerStats.max_hp
	hp_bar.value = PlayerStats.current_hp
	hp_text.text = str(PlayerStats.current_hp) + "/" + str(PlayerStats.max_hp)
	#STM BAR VALUES
	stm_bar.max_value = PlayerStats.max_stm
	stm_bar.value = PlayerStats.current_stm
	stm_text.text = str(PlayerStats.current_stm) + "/" + str(PlayerStats.max_stm)
	#MP BAR VALUES
	mp_bar.max_value = PlayerStats.max_mp
	mp_bar.value = PlayerStats.current_mp
	mp_text.text = str(PlayerStats.current_mp) + "/" + str(PlayerStats.max_mp)
	#STATS VALUES
	vigor_value.text = str(PlayerStats.vigor)
	arcane_value.text = str(PlayerStats.arcane)
	vitality_value.text = str(PlayerStats.vitality)
	alacrity_value.text = str(PlayerStats.alacrity)
	fortune_value.text = str(PlayerStats.fortune)
	##Money and Time
	money_value.text = str(PlayerStats.current_money)
	var h : String
	var m : String
	var s : String
	if PlayerManager.game_time_hours < 10:
		h = "0" + str(PlayerManager.game_time_hours)
	else:
		h = str(PlayerManager.game_time_hours)
	if PlayerManager.game_time_minutes < 10:
		m = "0" + str(PlayerManager.game_time_minutes)
	else:
		m = str(PlayerManager.game_time_minutes)
	if PlayerManager.game_time_seconds < 10:
		s = "0" + str(PlayerManager.game_time_seconds)
	else:
		s = str(PlayerManager.game_time_seconds)
	time_value.text = h + ":" + m + ":" + s
	


func _on_topics_button_button_up() -> void:
	if current_submenu == "Topics":
		topics_sub.visible = false
		topics_sub.process_mode = Node.PROCESS_MODE_DISABLED
		current_submenu = "None"
		return
	if current_submenu != "None":
		return
	else:
		current_submenu = "Topics"
		topics_sub.process_mode = Node.PROCESS_MODE_INHERIT
		topics_sub.visible = true


func _on_close_button_pressed() -> void:
	if current_submenu != "None":
		return
	PlayerStats.player_context = "Exploration"
	get_tree().paused = false
	self.queue_free()


func _on_exit_button_pressed() -> void:
	if current_submenu != "None":
		return
	get_tree().quit()


func _on_load_button_pressed() -> void:
	PlayerStats.player_context = "Exploration"
	get_tree().paused = false
	self.queue_free()
	SaveManager.load_game()
	await LevelManager.LevelLoadStarted


func _on_save_button_pressed() -> void:
	SaveManager.save_game()
	self.queue_free()
