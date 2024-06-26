class_name Interactable extends Area2D

@export var interact_label: String = "none"
@export var interact_type = "none"
@export var interact_value = ""
@export var interact_value2 = ""
@export var interact_value3 = ""

@onready var sprite_2d = $Sprite2D
#
#func _ready():
	#sprite_2d.texture = interact_image
