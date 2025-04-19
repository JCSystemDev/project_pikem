extends CharacterBody2D

const SPEED = 600
@onready var anim = $AnimationPlayer
@onready var camera: Camera2D = $Camera2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var bag: Sprite2D = $Pikem/Bag
@onready var pikem: Sprite2D = $Pikem

func _ready():
	DialogueManager.dialogue_screen.hide()
	if DataManager.stolen:
		bag.hide()
		if DataManager.event_num < 3:
			DataManager.player_control = false
			await get_tree().create_timer(1.5).timeout
			collision.disabled = false
			DataManager.player_control = true
			DataManager.event_num += 1
		collision.disabled = false
		DataManager.player_control = true
	elif DataManager.first_time:
		DataManager.player_control = false
		await get_tree().create_timer(1.5).timeout
		collision.disabled = false
		DataManager.first_time = false	
		DataManager.event_num += 1	
	else:
		collision.disabled = false
		DataManager.player_control = true

func _physics_process(_delta):
	if DataManager.player_control:
		var direction := Input.get_axis("left", "right")
		if direction:
			pikem.flip_h = true if direction > 0 else false
			bag.flip_h = true if direction > 0 else false
			velocity.x = direction * SPEED
			if get_tree().current_scene.name == "Underground2":
				anim.play("move fear")
			elif get_tree().current_scene.name == "Overworld2" or get_tree().current_scene.name == "Mousealley": 
				anim.play("move fearest")	
			else:
				anim.play("move")
			
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if get_tree().current_scene.name == "Underground2":
				anim.play("idle fear")
			elif get_tree().current_scene.name == "Overworld2" or get_tree().current_scene.name == "Mousealley": 
				anim.play("idle fearest")	
			else:
				anim.play("idle")

		move_and_slide()
		
	if DataManager.event_name == "Sleep":
		if pikem.flip_h:
			pikem.flip_h = false
		TweenManager._move_tween(pikem, pikem.position.x, -220, 0.2)
		if !DialogueManager.dialogue_screen.visible:
			anim.play("sleep")
		else:
			anim.play("sleeping")
		await get_tree().create_timer(0.4).timeout
		TweenManager._move_tween(bag, bag.position.x, 100, 0.1)
		await anim.animation_finished
		DataManager._get_dialogue(3, 1)
		DialogueManager._load_dialogue_box(DataManager.current_line, DataManager.current_name, DataManager.current_texture, DataManager.current_textbox)
		DialogueManager._play_dialogue_box()
		DataManager.stolen = true
	
	if DialogueManager.dialogue_screen.visible or !DataManager.player_control:
		if get_tree().current_scene.name == "Underground2":
			anim.play("idle fear")
		elif get_tree().current_scene.name == "Overworld2" or get_tree().current_scene.name == "Alley": 
			anim.play("idle fearest")	
		else:
			anim.play("wait")
		
