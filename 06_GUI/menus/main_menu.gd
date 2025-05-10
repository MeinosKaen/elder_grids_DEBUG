extends CanvasLayer

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

func _ready() -> void:
	get_tree().paused = true
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

func _input(event: InputEvent) -> void:
	if PlayerStats.player_context == "Main Menu":
		if event.is_action_pressed("cancel"):
			PlayerStats.player_context = "Exploration"
			get_tree().paused = false
			self.queue_free()
