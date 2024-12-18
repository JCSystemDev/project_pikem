extends Node2D

var path_sfx: String = "res://Assets/Audio/SFX/"
var path_music: String = "res://Assets/Audio/Music/"
@onready var sfx_stream: AudioStreamPlayer = $SFX
@onready var sfx_stream2: AudioStreamPlayer = $SFX2 
@onready var music_stream: AudioStreamPlayer = $Music

func play_sound(sound_name: String, audio_player: AudioStreamPlayer):
	var sound = load(path_sfx+sound_name)
	audio_player.stream = sound
	audio_player.play()

func stop_sound(audio_player: AudioStreamPlayer):
	audio_player.stop()

func play_music(music_name: String):
	var music = load(path_music+music_name)
	$"Music".stream = music
	$"Music".play()
