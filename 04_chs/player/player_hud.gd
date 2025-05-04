extends CanvasLayer

@onready var hp_bar: ProgressBar = $FullScreen/stats_bars/hp_bar
@onready var stm_bar: ProgressBar = $FullScreen/stats_bars/stm_bar
@onready var mp_bar: ProgressBar = $FullScreen/stats_bars/mp_bar

@onready var stats: Stats = $"../Stats"


func _ready() -> void:
	hp_bar.max_value = stats.max_hp
	hp_bar.value = stats.current_hp
	stm_bar.max_value = stats.max_stm
	stm_bar.value = stats.current_stm
	mp_bar.max_value = stats.max_mp
	mp_bar.value = stats.current_mp
	pass

func UpdateStatsHUD() -> void:
	hp_bar.value = stats.current_hp
	stm_bar.value = stats.current_stm
	mp_bar.value = stats.current_mp
