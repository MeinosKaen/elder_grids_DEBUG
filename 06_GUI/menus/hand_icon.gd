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
var submenu_buttons = [status_button, equip_button, items_button, topics_button, crt_button, save_button, load_button, close_button, exit_game_button]

var current_button : Node = null

func _ready() -> void:
	ButtonList.append_array(submenu_buttons)

func hand_position_update(new_x:int,new_y:int,new_button:Node) -> void:
	self.position.x = new_x -48
	self.position.y = new_y
	current_button = new_button

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_button != null:
			if current_button == topics_button:
				if main_menu.current_submenu != "None":
					return
				else:
					main_menu.current_submenu = "Topics"
					main_menu.topics_sub.process_mode = Node.PROCESS_MODE_INHERIT
					main_menu.topics_sub.visible = true
