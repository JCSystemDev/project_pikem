extends CharacterBody2D

const speed = 300
@onready var anim = $AnimationPlayer
var meow: bool
func _ready():
	
	meow = false
	
func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if !meow:	
		if direction:
			velocity.x = speed * direction.x
			velocity.y = speed * direction.y
		else:
			velocity.x = 0
			velocity.y = 0
		
		update_animations()
	
	move_and_slide()
	

func update_animations():
	if Input.is_action_just_pressed("ui_accept") and !meow:
		meow = true
	
	if meow:
		velocity = Vector2.ZERO
		anim.play("meow")
		await anim.animation_finished
		meow = false
	
	if Input.is_action_just_pressed("down"):
		anim.play("move_down")
	
	if Input.is_action_just_released("down") and velocity == Vector2.ZERO:
		anim.play("idle_down")
		
	if Input.is_action_just_pressed("up"):
		anim.play("move_up")
	
	if Input.is_action_just_released("up") and velocity == Vector2.ZERO:
		anim.play("idle_up")
		
	if Input.is_action_just_pressed("left"):
		anim.play("move_left")
	
	if Input.is_action_just_released("left") and velocity == Vector2.ZERO:
		anim.play("idle_left")
		
	if Input.is_action_just_pressed("right"):
		anim.play("move_right")
	
	if Input.is_action_just_released("right") and velocity == Vector2.ZERO:
		anim.play("idle_right")

	
