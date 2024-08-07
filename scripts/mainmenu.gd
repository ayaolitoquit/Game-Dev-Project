class_name MainMenu
extends Control
@onready var tutorial_panel = $"Tutorial Panel"
@onready var credits_panel = $CreditsPanel

func _ready():
	AudioManager.menu_bgm.play()

func _on_play_pressed():
	AudioManager.menu_bgm.stop()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_tutorial_pressed():
	tutorial_panel.show()

func _on_tutorial_back_button_pressed():
	tutorial_panel.hide()

func _on_credits_pressed():
	credits_panel.show()

func _on_texture_button_pressed():
	credits_panel.hide()

func _on_exit_pressed():
	get_tree().quit()
