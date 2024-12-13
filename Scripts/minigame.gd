extends Node2D

var score = 0
var lives = 3

func _on_pellet_collected():
	score += 10
	if _check_win_condition():
		_game_won()

func _on_ghost_collision():
	lives -= 1
	if lives <= 0:
		_game_over()

func _check_win_condition() -> bool:
	return get_tree().get_nodes_in_group("Coins").is_empty()

func _game_over():
	print("Game Over!")


func _game_won():
	print("You Win!")
