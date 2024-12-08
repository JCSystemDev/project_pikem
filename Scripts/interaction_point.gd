class_name Interaction_Point extends Area2D

@export var dialogue_act: int
@export var dialogue_line: int
@export var interaction_type: String
@export var interaction_texture: Texture2D
@export var scene_name: String
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
			TransitionManager.load_scene(TransitionManager.underground_scene, "Transition")

func _on_body_entered(body):
	if body.is_in_group(player_group):
		if interaction_type == "Dialogue":
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
		if interaction_type == "Dialogue":
			interaction_icon.hide()
			in_interaction = false
		elif interaction_type == "Scene":
			interaction_label.hide()
			in_interaction = false
		
