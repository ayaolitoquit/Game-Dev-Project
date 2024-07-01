extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	pass # Replace with function body.


func _on_quit_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_settings_pressed():
	pass # Replace with function body.
