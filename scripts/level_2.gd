extends Node2D

var on_mirror_body_detected = false
# Called when the node enters the scene tree for the first time.
@onready var player = $Player
@onready var pause = $pause

func _ready():
	Dialogic.signal_event.connect(on_dialogic_signal)
	pause.hide_pause()
	Game.current_level = 2
	Dialogic.VAR.level = "level2"
	
func _input(event):
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

func on_dialogic_signal(argument: String):
	if argument == "teleport":
		Game.mission_counter.emit()
		player.global_position = Vector2(3171,190)
	if argument == "dialogue_started":
		set_process_input(false)
	if argument == "dialogue_finished":
		set_process_input(true)
	if argument == "d_next_level":
		Game.current_level += 1
		#AudioManager.bgm.stop() ################################# 
		get_tree().change_scene_to_file("res://scenes/level_3.tscn")

