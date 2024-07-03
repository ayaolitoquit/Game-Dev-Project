extends Node2D

var instanced_item_scene = null
const LEVEL_1_PAPER = preload("res://scenes/level_1_paper.tscn")
@onready var pause = $pause


func _ready():
	pause.hide_pause()
	Dialogic.start("level1cutscene1")
	Game.connect("respawn_paper", respawn_papers)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	AudioManager.bgm.play()
	Dialogic.VAR.level = "level1"
	set_process_input(true)
	Input.MOUSE_MODE_HIDDEN

func _input(event):
	if Input.is_action_just_pressed("pause"):
		swap_pause_state()
		
#maybe i can hide the mouse
	if event is InputEventMouseMotion:
		if event.velocity == Vector2(0,0):
			Input.MOUSE_MODE_HIDDEN
		else:
			Input.MOUSE_MODE_VISIBLE

func swap_pause_state():
	if not pause.visible:
		pause.show_pause()
		get_tree().paused = true
	else:
		get_tree().paused = false
		pause.hide_pause()

func _on_dialogic_signal(argument:String):
	if argument == "d_next_level":
		Game.current_level += 1
		#AudioManager.bgm.stop() ################################# 
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	if argument == "dialogue_started":
		set_process_input(false)
	if argument == "dialogue_finished":
		set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func respawn_papers(initial_item_states: Array):
	for item_state in initial_item_states:
		var scene = item_state["scene"]
		var position = item_state["position"]
		
		# Check if the scene is a PackedScene and instance it
		if scene is PackedScene:
			var instance = scene.instantiate()
			if instance:
				# Set the instance position
				instance.global_position = position
				
				# Add the instance to the current scene tree
				add_child(instance)
				instance.call("initialize")
			else:
				print("Failed to instantiate the scene.")
		else:
			print("Invalid scene data.")

