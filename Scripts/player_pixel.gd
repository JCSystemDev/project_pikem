extends CharacterBody2D

const SPEED = 5
@onready var anim = $AnimationPlayer
var meow: bool
var direction = Vector2()

func _ready():
	meow = false
	
func _physics_process(_delta):
	if !meow:
		if(Input.is_action_pressed("up") and direction.x == 0):
			direction.y = -SPEED
		elif(Input.is_action_pressed("down") and direction.x == 0):
			direction.y = SPEED
			anim.play("move_down")
		elif(Input.is_action_pressed("left") and direction.y == 0):
			direction.x = -SPEED
		elif(Input.is_action_pressed("right") and direction.y == 0):
			direction.x = SPEED
		elif(Input.is_action_just_released("up")):
			direction = Vector2.ZERO	
		elif(Input.is_action_just_released("down")):
			direction = Vector2.ZERO
		elif(Input.is_action_just_released("left")):
			direction = Vector2.ZERO
		elif(Input.is_action_just_released("right")):
			direction = Vector2.ZERO
		else:
			anim.play("idle")
			direction = Vector2.ZERO
			
		move_and_collide(direction)
	_update_animations()

func _update_animations():
	if Input.is_action_just_pressed("ui_accept") and !meow:
		meow = true
	
	if meow:
		anim.play("meow")
		await anim.animation_finished
		meow = false
