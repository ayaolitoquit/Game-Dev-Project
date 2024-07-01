class_name MainMenu
extends Control
@onready var tutorial_panel = $"Tutorial Panel"

func _ready():
	AudioManager.menu_bgm.play()

func _on_play_pressed():
	AudioManager.menu_bgm.stop()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_tutorial_pressed():
	tutorial_panel.visible = true

func _on_back_button_pressed():
	tutorial_panel.visible = false
