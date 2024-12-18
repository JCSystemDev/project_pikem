extends CanvasLayer
var in_dialogue: bool
var in_conversation: bool
@onready var dialogue_animation = $AnimationPlayer
@onready var dialogue_label = $"Screen/Dialogue Label"
@onready var name_label = $"Screen/Name Label"
@onready var npc_label = $"Screen/Npc Label"
@onready var dialogue_screen = $"."
@onready var pikem: Sprite2D = $Screen/Pikem
@onready var arrow: Sprite2D = $Screen/Arrow
@onready var npc: Sprite2D = $Screen/NPC
@onready var dialogue_box: Sprite2D = $"Screen/Dialogue Box"
var line_cont: int = 1

func _ready():
	in_dialogue = false
	dialogue_screen.hide()
	arrow.hide()

func _input(event):
	if event.is_action_pressed("action") and !in_dialogue and dialogue_screen.visible:
		_close_dialogue()
	
func _play_dialogue_box():
	DataManager.player_control = false
	in_dialogue = true
	dialogue_screen.show()
	if DataManager.current_name == "PIKEM":
		name_label.show()
		npc_label.hide()
		pikem.show()
		npc.hide()
		if DataManager.event_name != "Sleep":
			AudioManager.play_sound("Meow.mp3", AudioManager.sfx_stream)
			TweenManager._jump_tween(pikem)
	if DataManager.current_name == "MOUSE":
		name_label.hide()
		npc_label.show()
		pikem.hide()
		npc.show()
		TweenManager._jump_tween(npc)
		AudioManager.play_sound("Squeak.ogg", AudioManager.sfx_stream)
	dialogue_animation.play("write_text")
	await dialogue_animation.animation_finished
	arrow.show()
	in_dialogue = false
	
func _load_dialogue_box(_line: String, _name: String, _avatar_texture: Texture2D, _textbox_texture: Texture2D):
	if _name == "PIKEM":
		name_label.set_text(_name)
		pikem.set_texture(_avatar_texture)
	elif _name == "MOUSE":
		npc_label.set_text(_name)
		npc.set_texture(_avatar_texture)
	dialogue_box.set_texture(_textbox_texture)
	dialogue_label.set_text(_line)
	
	
	
func _close_dialogue():
	if DataManager.event_name == "Sleep":
		TransitionManager.load_scene("res://Scenes/Levels/underground2.tscn", "Transition")
	elif DataManager.event_name == "Box":
		if line_cont < 11:
			line_cont += 1
			arrow.hide()
			_mouse_conversation()
		elif line_cont >= 11:
			line_cont = 0
			arrow.hide()
			dialogue_screen.hide()
			TransitionManager.load_scene("res://Scenes/Levels/codec.tscn", "Transition")
			DataManager.player_control = true
	elif DataManager.event_name == "": 
		arrow.hide()
		dialogue_screen.hide()
		DataManager.player_control = true

func _mouse_conversation():
	DataManager._get_dialogue(5,line_cont)
	_load_dialogue_box(DataManager.current_line, DataManager.current_name, DataManager.current_texture, DataManager.current_textbox)
	_play_dialogue_box()
