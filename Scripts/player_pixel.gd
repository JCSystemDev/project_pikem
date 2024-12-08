extends CharacterBody2D

const speed = 300
@onready var anim = $AnimationPlayer
var meow: bool
func _ready():
	
	meow = false
	
func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	if !meow:	
		if direction:
			velocity.x = speed * direction.x
			velocity.y = speed * direction.y
		else:
			velocity.x = 0
			velocity.y = 0
	
	move_and_slide()
	
