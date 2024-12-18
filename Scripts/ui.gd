extends CanvasLayer
@onready var pikem_ui = $"Pikem UI"
@onready var coins_label: Label = $"Pikem UI/Coins"
@onready var anim: AnimatedSprite2D = $"Pikem UI/Avatar"
var coins: int = 0
var pikem_live: bool
var player_control: bool
var in_chase: bool

func _ready():
	player_control = true
	pikem_live = true
	pikem_ui.hide()
	coins_label.text = str(coins)
	
func _process(_delta):
	if in_chase:
		anim.play("chased")
	elif !in_chase:
		anim.play("normal")
	coins_label.text = str(coins)
