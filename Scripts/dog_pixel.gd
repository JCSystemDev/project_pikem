extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $Dog
@export var speed: float = 150.0
@export var patrol_speed: float = 100.0
@export var chase_distance: float = 400.0
@export var return_to_patrol_distance: float = 150.0
@export var patrol_points: Array[Vector2] = []  # Lista de puntos para patrullar

@onready var detection_area = $"Detection Area"
@onready var pikem = get_parent().get_node("Player_Pixel")

enum State { PATROL, CHASE }
var current_state = State.PATROL
var patrol_index = 0  # Índice del punto actual en la patrulla

func _ready():
	if patrol_points.size() > 0:
		global_position = patrol_points[0]

func _physics_process(delta):
	match current_state:
		State.PATROL:
			_patrol(delta)
		State.CHASE:
			_chase(delta)

func _patrol(delta):
	var target = patrol_points[patrol_index]
	var direction = (target - global_position).normalized()
	velocity = direction * patrol_speed
	move_and_slide()
	
	# Cambiar al siguiente punto si alcanzamos el actual
	if global_position.distance_to(target) < 5:
		patrol_index = (patrol_index + 1) % patrol_points.size()

	if global_position.distance_to(pikem.global_position) <= chase_distance:
		current_state = State.CHASE

func _chase(delta):
	var direction = (pikem.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

	# Volver a patrullar si Pac-Man se aleja demasiado
	if global_position.distance_to(pikem.global_position) > return_to_patrol_distance:
		current_state = State.PATROL

func _on_DetectionArea_body_entered(body):
	if body.name == "Player_Pixel" and current_state != State.CHASE:
		current_state = State.CHASE
