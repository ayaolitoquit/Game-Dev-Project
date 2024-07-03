extends Node2D

@onready var pause = $pause
@onready var player_flashlight = $Player/player_flashlight
@onready var to_be_continued = $"to be continued"

func _ready():
	Game.connect("flashlight_acquired", on_flashlight_acquired)
	pause.hide_pause()
	set_process_input(true)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		swap_pause_state()

func swap_pause_state():
	if not pause.visible:
		pause.show_pause()
		get_tree().paused = true
		Dialogic.paused = true

	else:
		get_tree().paused = false
		pause.hide_pause()
		Dialogic.paused = false

func _on_dialogic_signal(argument: String):
	if argument == "dialogue_started":
		set_process_input(false)
	if argument == "dialogue_finished":
		set_process_input(true)
	if argument == "d_next_level":
		Game.current_level += 1
		#AudioManager.bgm.stop() ################################# 
		get_tree().change_scene_to_file("res://scenes/level_5.tscn")

func on_flashlight_acquired():
	player_flashlight.show()

func _on_area_2d_body_entered(body):
	print("tumama")
	if body.name == "Player":
		print("nadetect")
		to_be_continued.show()
