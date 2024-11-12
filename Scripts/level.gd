extends Node2D

@onready var left_door = $"Background/Doors/L Door"
@onready var right_door = $"Background/Doors/R Door"
var open: bool = false

func _input(event):
	if event.is_action_pressed("Start"):
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		if !open:
			open = true
			tween.tween_property(left_door, "position", Vector2(60, -213), 0.5)
			tween2.tween_property(right_door, "position", Vector2(913, -213), 0.5)
		else:
			tween.tween_property(left_door, "position", Vector2(339, -213), 0.5)
			tween2.tween_property(right_door, "position", Vector2(634, -213), 0.5)
			open = false
