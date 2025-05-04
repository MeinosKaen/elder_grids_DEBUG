extends Label

@onready var ch_player: Player = $"../../../.."

func _process(delta: float) -> void:
	text = "PLAYER POS = " + str(ch_player.global_position)
	
