extends Control
@onready var new_game: Button = $UI/Start
@onready var quit_game: Button = $UI/Exit
@onready var pikem = $Background/Pikem
@onready var pikem_anim: AnimatedSprite2D = $Background/Pikem/AnimatedSprite2D
@onready var left_door = $"Background/Doors/Door Left"
@onready var right_door = $"Background/Doors/Door Right" 

func _ready():
	AudioManager.play_music("Menu.ogg")
	pikem_anim.play("Idle")
	TransitionManager.transition_canvas.show()
	TransitionManager.animation_player.play_backwards("Transition")

func _on_exit_pressed():
	quit_game.hide()
	new_game.hide()
	TransitionManager.quit_transition("Transition")

func _on_start_pressed():
	AudioManager.play_sound("Doors.ogg")
	new_game.hide()
	quit_game.hide()
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(left_door, "position", Vector2(282, 130), 0.5)
	tween2.tween_property(right_door, "position", Vector2(584, 130), 0.5)
	await get_tree().create_timer(0.5).timeout
	pikem.z_index = 4
	var tween3 = get_tree().create_tween()
	AudioManager.play_sound("Meow.mp3")
	pikem_anim.play("Jump")
	tween3.tween_property(pikem, "position", Vector2(0, 72), 0.25)
	await get_tree().create_timer(0.25).timeout
	pikem_anim.play("Idle")
	await get_tree().create_timer(0.25).timeout
	TransitionManager.load_scene(TransitionManager.overworld_scene, "Transition")
	
