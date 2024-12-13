extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $PIKEM
@export var speed: float = 200.0


func _physics_process(delta):
	var direction = Vector2.ZERO	
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		anim.play("Move Up")
	elif Input.is_action_just_released("ui_up"):
		anim.play("Idle Up")
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
		anim.play("Move Down")
	elif Input.is_action_just_released("ui_down"):
		anim.play("Idle Down")
	elif Input.is_action_pressed("ui_left"):
		direction.x = -1
		anim.play("Move Left")
	elif Input.is_action_just_released("ui_left"):
		anim.play("Idle Left")
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
		anim.play("Move Right")
	elif Input.is_action_just_released("ui_right"):
		anim.play("Idle Right")
	
	velocity = direction.normalized() * speed
	move_and_slide()
	
