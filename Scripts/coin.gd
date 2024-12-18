extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		UIManager.coins += 1
		AudioManager.play_sound("Coin.wav", AudioManager.sfx_stream)
		queue_free()
		
