extends CharacterBody2D

const SPEED = 300.0
@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		anim.flip_h = false if direction > 0 else true
		velocity.x = direction * SPEED
		anim.play("move")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
