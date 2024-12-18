extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		UIManager.player_control = false
		AudioManager.play_sound("Inacubo.wav", AudioManager.sfx_stream)
		await get_tree().create_timer(1).timeout
		TransitionManager.load_scene("res://Scenes/Levels/codec2.tscn", "Transition")
