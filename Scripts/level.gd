extends Node2D

@onready var left_door = $"Background/Doors/L Door"
@onready var right_door = $"Background/Doors/R Door"

func _input(event):
	if event.is_action_pressed("Start"):
		print("ABRIR PUERTAS")
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property(left_door, "position", Vector2(60, -213), 0.5)
		tween2.tween_property(right_door, "position", Vector2(913, -213), 0.5)
		
