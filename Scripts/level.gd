class_name Level extends Node2D
var player: PackedScene = load("res://Scenes/Characters/player.tscn")
@export var player_pos: Marker2D
@export var bg_music: String
@export var level_bounds: Rect2

func _ready():
	AudioManager.play_music(bg_music)
	var player_instance = player.instantiate()
	player_instance.global_position = player_pos.global_position
	add_child(player_instance)
	var camera: Camera2D = player_instance.get_node("Camera2D")
	camera.limit_left = int(level_bounds.position.x)
	camera.limit_right = int(level_bounds.position.x + level_bounds.size.x)
	camera.limit_top = int(level_bounds.position.y)
	camera.limit_bottom = int(level_bounds.position.y + level_bounds.size.y)
	await get_tree().create_timer(1.5).timeout
