extends Node2D

@onready var pause = $pause

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.current_level = 3
	#Dialogic.start("level3cutscene")
	pause.hide_pause()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.VAR.level = "level3"


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
		get_tree().change_scene_to_file("res://scenes/level_4.tscn")
