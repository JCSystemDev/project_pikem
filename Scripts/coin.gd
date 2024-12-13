extends Area2D

func _on_body_entered(body):
	if body.name == "Player_Pixel":
		queue_free()  # Elimina el pellet del juego
