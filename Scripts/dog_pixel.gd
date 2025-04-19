extends CharacterBody2D
@export var speed: float = 100
@export var patrol_points: Array[Marker2D] = []
var current_point_index = 0
@onready var anim: AnimatedSprite2D = $Dog
@onready var detection_area: Area2D = $Area2D
var player: Node2D = null
var chase_sound: bool = false

func _ready():
	detection_area.body_entered.connect(_on_player_detected)
	detection_area.body_exited.connect(_on_player_lost)

func _on_player_detected(body: Node2D):
	if body.name == "Player":
		player = body
		UIManager.in_chase = true
	
func _on_player_lost(body: Node2D):
	if body == player:
		player = null
		UIManager.in_chase = false
		AudioManager.stop_sound(AudioManager.sfx_stream2)
		chase_sound = false
	
func _process(_delta):
	if velocity.x > 0:
		anim.flip_h = true
	elif velocity.x < 0:
		anim.flip_h = false
	elif velocity.x == 0 and velocity.y == 0:
		anim.play("Idle")
	
	if player:
		anim.play("Chase")
		_chase_player()
	else:
		anim.play("Patrol")
		_patrol()

	move_and_slide()

func _chase_player():
	if !chase_sound:
		AudioManager.play_sound("Dog Growl.ogg", AudioManager.sfx_stream2)
		chase_sound = true	
	velocity = (player.global_position - global_position).normalized() * speed

func _patrol():
	if patrol_points.size() > 0:
		var target = patrol_points[current_point_index].position
		velocity = (target - position).normalized() * speed
		
		if position.distance_to(target) < 10.0:
			current_point_index += 1
			if current_point_index >= patrol_points.size():
				current_point_index = 0	
		
func _on_hitbox_body_entered(body):
	if body.name == "Player":
		AudioManager.play_sound("Death.ogg", AudioManager.sfx_stream)
		UIManager.pikem_live = false
