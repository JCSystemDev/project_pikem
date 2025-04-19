extends Node2D

@onready var anim_bag: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_area_entered(area):
	if area.name == "Attack Area":
		_destroy()
		
func _destroy():
	AudioManager.play_sound("Trash.ogg", AudioManager.sfx_stream2)
	anim_bag.play("Destroyed")
	await anim_bag.animation_finished
	queue_free()
