class_name Interactable extends Area2D

@export var interact_label: String = "none"
@export var interact_type = "none"
@export var interact_value = "Description"
@export var interactable_image = preload("res://assets/icon.svg")

@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.texture = interactable_image
