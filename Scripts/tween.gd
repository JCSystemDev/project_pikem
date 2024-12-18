extends Node

func _jump_tween(node: Node):
	var jump = create_tween()
	jump.tween_property(node, "position", Vector2(node.position.x, node.position.y - 15), 0.25)
	jump.tween_property(node, "position",node.position, 0.25)

func _move_tween(node: Node, posx: float, posy: float, time: float):
	var move = create_tween()
	move.tween_property(node, "position", Vector2(posx, posy),time)

func _appears_vertical(node: Node):
	var appears = create_tween()
	appears.tween_property(node, "scale", Vector2(node.scale.x, 0), 0)
	appears.tween_property(node, "scale", Vector2(node.scale.x, node.scale.y), 0.25)
	
