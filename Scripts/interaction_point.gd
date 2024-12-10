class_name Interaction_Point extends Area2D

@export var dialogue_act: int
@export var dialogue_line: int
@export var interaction_type: String
@export var interaction_texture: Texture2D
@export var scene_name: String
@export var event_name: String
@onready var interaction_icon: Sprite2D = $Icon
@onready var interaction_label: Label = $Label
@onready var collision: CollisionShape2D = $CollisionShape2D

var in_interaction: bool = false
var player_group: String = "Player" 

func _ready():
	interaction_label.set_text(scene_name)
	interaction_icon.hide()
	interaction_label.hide()
	interaction_icon.set_texture(interaction_texture)	
	
func _input(event):
	if in_interaction and event.is_action_pressed("ui_accept"):
		if DialogueManager.in_dialogue:
			DialogueManager._close_dialogue()
		elif interaction_type == "Dialogue":
			DataManager._get_dialogue(dialogue_act, dialogue_line)
			DialogueManager._load_dialogue_box(DataManager.current_line, DataManager.current_name, DataManager.current_texture)
			DialogueManager._play_dialogue_box()
		elif interaction_type == "Scene":
			if interaction_label.text == "ENTRADA":
				TransitionManager.load_scene(TransitionManager.underground_scene, "Transition")
			elif interaction_label.text == "SALIDA":
				TransitionManager.load_scene(TransitionManager.overworld_scene2, "Transition")
		elif interaction_type == "Event":
			DataManager.player_control = false
			interaction_icon.hide()
			DataManager.event_name = event_name
			if DataManager.event_name == "Train":
				var trains = get_tree().get_nodes_in_group("Train")
				var players = get_tree().get_nodes_in_group("Player")
				var train = trains[0]
				var player = players[0]
				TweenManager._move_tween(train, -1450, 0, 7)
				AudioManager.play_sound("Stop Train.mp3")
				await get_tree().create_timer(7).timeout
				AudioManager.play_sound("Open Train.wav")
				await get_tree().create_timer(2).timeout
				AudioManager.play_sound("Close Train.wav")
				await get_tree().create_timer(2).timeout
				player.queue_free()
				AudioManager.play_sound("Start Train.wav")
				TweenManager._move_tween(train, -5450, 0, 5)
				await get_tree().create_timer(7).timeout
				TransitionManager.load_scene(TransitionManager.train_scene, "Transition")

func _on_body_entered(body):
	if body.is_in_group(player_group):
		if interaction_type == "Dialogue" or interaction_type == "Event":
			interaction_icon.show()
			in_interaction = true
		elif interaction_type == "Scene":
			interaction_label.show()
			in_interaction = true
		elif interaction_type == "Trigger":
			DataManager._get_dialogue(dialogue_act, dialogue_line)
			DialogueManager._load_dialogue_box(DataManager.current_line, DataManager.current_name, DataManager.current_texture)
			DialogueManager._play_dialogue_box()
			collision.queue_free()
			
		
func _on_body_exited(body):
	if body.is_in_group(player_group):
		if interaction_type == "Dialogue" or interaction_type == "Event":
			interaction_icon.hide()
			in_interaction = false
		elif interaction_type == "Scene":
			interaction_label.hide()
			in_interaction = false
		