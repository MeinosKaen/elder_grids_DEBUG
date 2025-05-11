extends TextureRect
@onready var main_menu: CanvasLayer = $".."

@onready var status_button: Control = $"../SubMenus/Status_Button/StatusButton"
@onready var equip_button: Control = $"../SubMenus/Equip_Button/EquipButton"
@onready var items_button: Control = $"../SubMenus/Items_Button/ItemsButton"
@onready var topics_button: Control = $"../SubMenus/Topics_Button/TopicsButton"
@onready var crt_button: Control = $"../SubMenus/CRT_Button/CRTButton"
@onready var save_button: Control = $"../SubMenus/Save_Button/SaveButton"
@onready var load_button: Control = $"../SubMenus/Load_Button/LoadButton"
@onready var close_button: Control = $"../SubMenus/Close_Button/CloseButton"
@onready var exit_game_button: Control = $"../SubMenus/ExitGame_Button/ExitButton"
var ButtonList : Array = []

var current_button : Node = null
var current_button_id : int = 0

func _ready() -> void:
	ButtonList.append(status_button)
	ButtonList.append(equip_button)
	ButtonList.append(items_button)
	ButtonList.append(topics_button)
	ButtonList.append(crt_button)
	ButtonList.append(save_button)
	ButtonList.append(load_button)
	ButtonList.append(close_button)
	ButtonList.append(exit_game_button)
	current_button = ButtonList[current_button_id]

func hand_position_update(new_x:int,new_y:int,new_button:Node) -> void:
	self.position.x = new_x -48
	self.position.y = new_y
	current_button = new_button

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_down"):
		current_button_id +=1
		if current_button_id == ButtonList.size():
			current_button_id = 0
		var new_button = ButtonList[current_button_id]
		hand_position_update(new_button.global_position.x,new_button.global_position.y,new_button)
	elif event.is_action_released("ui_up"):
		current_button_id -=1
		if current_button_id < 0:
			current_button_id = ButtonList.size()-1
		var new_button = ButtonList[current_button_id]
		hand_position_update(new_button.global_position.x,new_button.global_position.y,new_button)
	if event.is_action_released("interact"):
		if current_button != null:
			if current_button == topics_button:
				if main_menu.current_submenu != "None":
					return
				else:
					main_menu.current_submenu = "Topics"
					main_menu.topics_sub.process_mode = Node.PROCESS_MODE_INHERIT
					main_menu.topics_sub.visible = true
			if current_button == crt_button:
				if main_menu.post_effects == true:
					PlayerManager.player.post_process_node.visible = false
					PlayerManager.player.post_process_node.process_mode = Node.PROCESS_MODE_DISABLED
					main_menu.post_effects = false
				elif main_menu.post_effects == false:
					PlayerManager.player.post_process_node.visible = true
					PlayerManager.player.post_process_node.process_mode = Node.PROCESS_MODE_INHERIT
					main_menu.post_effects = true
			if current_button == close_button:
				PlayerStats.player_context = "Exploration"
				get_tree().paused = false
				main_menu.queue_free()
			if current_button == exit_game_button:
				get_tree().quit()
			if current_button == load_button:
				PlayerStats.player_context = "Exploration"
				get_tree().paused = false
				main_menu.queue_free()
				SaveManager.load_game()
				await LevelManager.LevelLoadStarted
			if current_button == save_button:
				SaveManager.save_game()
				main_menu.queue_free()
