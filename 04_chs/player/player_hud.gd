extends CanvasLayer

@onready var hp_bar: ProgressBar = $FullScreen/stats_bars/hp_bar
@onready var stm_bar: ProgressBar = $FullScreen/stats_bars/stm_bar
@onready var mp_bar: ProgressBar = $FullScreen/stats_bars/mp_bar

var recharge_clicks = 0

func _ready() -> void:
	hp_bar.max_value = PlayerStats.max_hp
	hp_bar.value = PlayerStats.current_hp
	stm_bar.max_value = PlayerStats.max_stm
	stm_bar.value = PlayerStats.current_stm
	mp_bar.max_value = PlayerStats.max_mp
	mp_bar.value = PlayerStats.current_mp
	pass

func _process(delta: float) -> void:
	recharge_clicks += 1
	if recharge_clicks == 60:
		if PlayerStats.current_hp < PlayerStats.max_hp:
			PlayerStats.current_hp += 1
		if PlayerStats.current_stm < PlayerStats.max_stm:
			PlayerStats.current_stm += 1
		if PlayerStats.current_mp < PlayerStats.max_mp:
			PlayerStats.current_mp += 1
		recharge_clicks = 0
		UpdateStatsHUD()
	else:
		pass

func UpdateStatsHUD() -> void:
	hp_bar.value = PlayerStats.current_hp
	stm_bar.value = PlayerStats.current_stm
	mp_bar.value = PlayerStats.current_mp
