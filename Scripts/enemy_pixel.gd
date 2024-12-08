extends CharacterBody2D

@export var speed: float = 0.1  # Velocidad de progreso (0.0 a 1.0 por segundo)
@onready var path_follow = $".."

func _process(delta):
	# Incrementa el progreso normalizado
	path_follow.progress_ratio += speed * delta
	
	# Reinicia si supera 1.0 (bucle)
	if path_follow.progress_ratio > 1.0:
		path_follow.progress_ratio = 0.0
