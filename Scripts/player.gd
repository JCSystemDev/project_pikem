extends CharacterBody2D

const SPEED = 500
@onready var anim = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	await get_tree().create_timer(1.5).timeout
	collision.disabled = false

func _physics_process(_delta):
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and !DialogueManager.visible:
		anim.flip_h = true if direction > 0 else false
		velocity.x = direction * SPEED
		anim.play("move")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
