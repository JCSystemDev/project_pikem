extends Node

func _jump_tween(node: Node):
	var position = node.position
	var jump = create_tween()
	jump.tween_property(node, "position", Vector2(position.x, position.y - 15), 0.25)
	jump.tween_property(node, "position", position, 0.25)

func _move_tween(node: Node, posx: float, posy: float, time: float):
	var position = node.position
	var move = create_tween()
	move.tween_property(node, "position", Vector2(posx, posy),time)
