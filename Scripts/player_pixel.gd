extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $PIKEM
@export var speed: float = 200.0
@onready var attack_col: CollisionShape2D = $"Attack Area/CollisionShape2D"
@onready var col: CollisionShape2D = $CollisionShape2D
var is_attacking: bool
var last_direction: Vector2
var direction: Vector2
@onready var attack_area: Area2D = $"Attack Area"

func _ready():
	attack_col.disabled = true
	last_direction.y = 1
	
func _physics_process(_delta):
	direction = Vector2.ZERO
	
	if !UIManager.player_control and UIManager.pikem_live:
		anim.play("Idle Up")
	
	if !UIManager.pikem_live:
		col.disabled = true
		UIManager.player_control = false
		anim.play("Death")
		await anim.animation_finished
		queue_free()
		TransitionManager.load_scene("res://Scenes/Levels/minigame.tscn", "Transition")
	
	if Input.is_action_just_pressed("action") and !is_attacking and UIManager.player_control:
		_attack()
		
	if UIManager.player_control:
		if Input.is_action_pressed("up") and !is_attacking:
			direction.y = -1
			anim.play("Move Up")
		elif Input.is_action_just_released("up") and !is_attacking:
			anim.play("Idle Up")
		elif Input.is_action_pressed("down") and !is_attacking:
			direction.y = 1
			anim.play("Move Down")
		elif Input.is_action_just_released("down") and !is_attacking:
			anim.play("Idle Down")
		elif Input.is_action_pressed("left") and !is_attacking:
			direction.x = -1
			anim.play("Move Left")
		elif Input.is_action_just_released("left") and !is_attacking:
			anim.play("Idle Left")
		elif Input.is_action_pressed("right") and !is_attacking:
			direction.x = 1
			anim.play("Move Right")
		elif Input.is_action_just_released("right") and !is_attacking:
			anim.play("Idle Right")
	
	velocity = direction.normalized() * speed
	
	if direction.x != 0 or direction.y != 0:
		last_direction = direction
	
	move_and_slide()

func _attack():
	direction = Vector2.ZERO
	is_attacking = true
	attack_col.disabled = false
	AudioManager.play_sound("Slash.wav", AudioManager.sfx_stream)
	if last_direction.x < 0:
		attack_area.position.x = -20
		attack_area.position.y = 5
		anim.play("Attack Left")
		await anim.animation_finished
		anim.play("Idle Left")
	elif last_direction.x > 0:
		attack_area.position.x = 20
		attack_area.position.y = 5
		anim.play("Attack Right")
		await anim.animation_finished
		anim.play("Idle Right")
	elif last_direction.y < 0:
		attack_area.position.x = 0
		attack_area.position.y = -15 
		anim.play("Attack Up")
		await anim.animation_finished
		anim.play("Idle Up")
	elif last_direction.y > 0:
		attack_area.position.x = 0
		attack_area.position.y = 20 
		anim.play("Attack Down")
		await anim.animation_finished
		anim.play("Idle Down")
	is_attacking = false
	attack_col.disabled = true
