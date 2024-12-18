extends Node

# Data Base Access
var dialogues = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/dialogues.json"))
var npcs = JSON.parse_string(FileAccess.get_file_as_string("res://Data Base/npcs.json"))

# Variables
var in_train = false
var event_num: int = 0
var mouse_dialogue: bool = false
var stolen: bool = false
var player_control: bool = true
var event_name: String
var first_time: bool
var current_line: String
var current_texture: Texture2D
var current_name: String
var current_textbox: Texture2D

# NPC Variables
var npc_name: String
var npc_texture: Texture2D
var npc_dialogue_box: Texture2D
var npc_line: String

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _get_dialogue(act: int, line: int):
	for dialogue in dialogues:
		if dialogue["act_number"] == act:
			for dialogue_line in dialogue["lines"]:
				if dialogue_line["line_number"] == line:
					current_name = dialogue_line["name"]
					current_line = dialogue_line["line"]
					current_texture = load(dialogue_line["emotion"])
					current_textbox = load(dialogue_line["textbox"])
	
func _get_npc_textures(_name: String):
	for npc in npcs:
		if npc["npc_name"] == name:
			npc_texture = npc["npc_avatar"]
			npc_dialogue_box = npc["npc_dialogue_box"]
