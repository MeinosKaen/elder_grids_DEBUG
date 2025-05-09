@icon("res://icons/04_Dialogue.jpg")
class_name NPCDialogueCheck extends Area2D

var npc : Node
var player_in_range : bool = false
var dialogue_node = self

# 1-Gotta feel when the Player gets in the area. 2-Gotta activate the variable that lets the input button work. 3-Gotta make the NPC pause and turn towards the player.
# 4-Once the dialogue is finished, unpause the NPC. Done.
func _ready() -> void:
	var p = get_parent()
	npc = p
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	PlayerStats.DialogueFinished.connect(dialogue_finished)

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range == false:
		return
	else:
		if event.is_action_pressed("interact"):
			if PlayerStats.player_context != "Dialogue":
				PlayerStats.player_context = "Dialogue"
				npc.UpdateDirection(PlayerManager.player.global_position)
				npc.state = "idle"
				npc.velocity = Vector2.ZERO
				npc.UpdateAnimation()
				npc.do_behaviour = false
				Dialogic.start(npc.dialogue_script)
		
func dialogue_finished() -> void:
	Dialogic.end_timeline()
	npc.state = "idle"
	npc.UpdateAnimation()
	npc.do_behaviour = true
	npc.do_behaviour_enabled.emit()
	PlayerStats.player_context = "Exploration"
	if npc.fixed_position != "None":
		npc.direction_name = npc.fixed_position
		npc.UpdateAnimation()
	pass

func _on_area_entered(_a:Area2D) -> void:
	print("Player is close enough.")
	player_in_range = true
func _on_area_exited(_a:Area2D) -> void:
	player_in_range = false
	print("Player has left the area.")
