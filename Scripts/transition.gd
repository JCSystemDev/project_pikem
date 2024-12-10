extends CanvasLayer

var in_transition: bool
@onready var overworld_scene: PackedScene = load("res://Scenes/Levels/overworld.tscn")
@onready var underground_scene: PackedScene = load("res://Scenes/Levels/underground.tscn")
@onready var train_scene: PackedScene = load("res://Scenes/Levels/train.tscn")
@onready var memu_scene: PackedScene = load("res://Scenes/Menu/menu.tscn")
@onready var underground_scene2: PackedScene = load("res://Scenes/Levels/underground2.tscn")
@onready var overworld_scene2: PackedScene = load("res://Scenes/Levels/overworld2.tscn")

@onready var crossfade = $Crossfade
@onready var animation_player = $AnimationPlayer
@onready var transition_canvas = $"."

func _ready():
	transition_canvas.hide()
	crossfade.visible = false
	in_transition = false

func load_scene(target_scene: PackedScene, transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	crossfade.visible = false
	transition_canvas.hide()
	
func reaload_scene(transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards(transition)
	await animation_player.animation_finished
	crossfade.visible = false
	transition_canvas.hide()
	
func play_transition(transition: String):
	transition_canvas.show()
	in_transition = true
	animation_player.play(transition)
	await animation_player.animation_finished
	in_transition = false
	animation_player.play("RESET")
	transition_canvas.hide()

func quit_transition(transition: String):
	transition_canvas.show()
	animation_player.play(transition)
	await animation_player.animation_finished
	get_tree().quit()
