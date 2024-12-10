extends CharacterBody2D

const SPEED = 500
@onready var anim = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var bag: Sprite2D = $Pikem/Bag
@onready var pikem: Sprite2D = $Pikem

func _ready():
	if DataManager.stolen:
		bag.hide()
		DataManager.player_control = false
		await get_tree().create_timer(1).timeout
		collision.disabled = false
		
	if DataManager.first_time:
		DataManager.player_control = false
		await get_tree().create_timer(1).timeout
		collision.disabled = false
		DataManager.first_time = false		
	else:
		collision.disabled = false
		DataManager.player_control = true

func _physics_process(_delta):
	if DataManager.player_control and !DialogueManager.in_dialogue:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			pikem.flip_h = true if direction > 0 else false
			bag.flip_h = true if direction > 0 else false
			velocity.x = direction * SPEED
			anim.play("move")
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			anim.play("idle")

		move_and_slide()
	elif !DataManager.player_control and DataManager.event_name != "Sleep":
		anim.play("idle")
	elif DataManager.event_name == "Sleep":
		if pikem.flip_h:
			pikem.flip_h = false
		anim.play("sleep")
		await anim.animation_finished
		anim.play("sleeping")
		DataManager._get_dialogue(3, 1)
		DialogueManager._load_dialogue_box(DataManager.current_line, DataManager.current_name, DataManager.current_texture)
		DialogueManager._play_dialogue_box()
		DataManager.stolen = true
		
