extends CanvasLayer
var in_dialogue: bool
@onready var dialogue_animation = $AnimationPlayer
@onready var dialogue_label = $"Screen/Dialogue Label"
@onready var name_label = $"Screen/Name Label"
@onready var dialogue_screen = $"."
@onready var pikem: Sprite2D = $Screen/Pikem
@onready var arrow: Sprite2D = $Screen/Arrow
@onready var npc: Sprite2D = $Screen/NPC
@onready var dialogue_box: Sprite2D = $"Screen/Dialogue Box"

func _ready():
	in_dialogue = false
	dialogue_screen.hide()
	arrow.hide()
	
func _input(event):
	if event.is_action_pressed("ui_accept") and !in_dialogue and dialogue_screen.visible:
		_close_dialogue()
	
func _play_dialogue_box():
	if !dialogue_screen.visible:
		DataManager.player_control = false
		in_dialogue = true
		dialogue_screen.show()
		if DataManager.current_name == "PIKEM":
			if DataManager.event_name != "Sleep":
				AudioManager.play_sound("Meow.mp3")
				TweenManager._jump_tween(pikem)
		dialogue_animation.play("write_text")
		await dialogue_animation.animation_finished
		arrow.show()
		in_dialogue = false
	
func _load_dialogue_box(_line: String, _name: String, _texture: Texture2D):
	name_label.set_text(_name)
	dialogue_label.set_text(_line)
	pikem.set_texture(_texture)
	
func _close_dialogue():
	if !in_dialogue:
		if DataManager.event_name != "Sleep":
			arrow.hide()
			dialogue_screen.hide()
			DataManager.player_control = true
		elif DataManager.event_name == "Sleep":
			arrow.hide()
			dialogue_screen.hide()
			TransitionManager.load_scene(TransitionManager.underground_scene2, "Transition")
