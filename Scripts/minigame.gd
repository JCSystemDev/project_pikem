extends Node2D
@export var level_bounds: Rect2

func _ready():
	AudioManager.play_music("Minigame.ogg")
	UIManager.pikem_live = true
	UIManager.coins = 0
	UIManager.pikem_ui.show()
	UIManager.player_control = false
	await get_tree().create_timer(0.5).timeout
	UIManager.player_control = true
