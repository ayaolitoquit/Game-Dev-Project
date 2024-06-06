class_name MainMenu
extends Control

#@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
##@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
##@export var start_level = preload("res://scenes/main.tscn") as PackedScene
#
#func _ready():
	##play_button.button_down.connect(_on_play_button_down)
	##exit_button.button_down.connect(_on_exit_button_down)
	#pass
#
#
	#
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed():
	get_tree().quit()
