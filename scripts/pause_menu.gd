extends Node2D

func _ready():
	pass 

func _process(_delta):
	pass

func show_pause():
	visible = true
	for child in get_children():
		child.visible = true

func hide_pause():
	visible = false
	for child in get_children():
		child.visible = false

func _on_resume_pressed():
	get_parent().swap_pause_state()

func _on_restart_pressed():
	#Game.emit_signal("reset_level")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_to_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	AudioManager.bgm.stop()

func _on_settings_pressed():
	pass # Replace with function body.
