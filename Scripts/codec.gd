extends Node2D
@onready var ui_codec = $UI
@onready var dialogue_label: Label = $UI/Dialogue
@onready var pikem: AnimatedSprite2D = $UI/Pikem
@onready var mouse: AnimatedSprite2D = $UI/Mouse
@onready var anim: AnimationPlayer = $AnimationPlayer
@export var total_lines: int 
@export var act: int
var line: int = 1
var in_dialogue: bool
var player_control: bool

func _ready():
	UIManager.pikem_ui.hide()
	AudioManager.play_music("Codec.ogg")
	mouse.play("Silence")
	pikem.play("Silence")
	player_control = false
	dialogue_label.hide()
	await get_tree().create_timer(1).timeout
	player_control = true
	
func _process(_delta):
	if Input.is_action_just_pressed("action") and player_control:
		if line <= total_lines and !in_dialogue:
			_code_conversation()
		elif line > total_lines and !in_dialogue:
			dialogue_label.hide()
			mouse.play("Silence")
			pikem.play("Silence")
			await get_tree().create_timer(1).timeout
			if act == 6:
				TransitionManager.load_scene("res://Scenes/Levels/minigame.tscn", "Transition")
			elif act == 7:
				TransitionManager.load_scene("res://Scenes/Menu/menu.tscn", "Crossfade")
		
func _code_conversation():
	in_dialogue = true
	DataManager._get_dialogue(act,line)
	dialogue_label.text = DataManager.current_line
	if DataManager.current_name == "PIKEM":
		AudioManager.play_sound("Meow.mp3", AudioManager.sfx_stream)
		pikem.play("Talk")
		mouse.play("Silence")
	elif DataManager.current_name == "MOUSE":
		AudioManager.play_sound("Squeak.ogg", AudioManager.sfx_stream)
		pikem.play("Silence")
		mouse.play("Talk")
	anim.play("write_text")
	await anim.animation_finished
	in_dialogue = false
	line += 1
