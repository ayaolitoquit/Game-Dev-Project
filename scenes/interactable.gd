class_name Interactable extends Area2D

@export var interact_label: String = "none"
@export var interact_type = "none"
@export var interact_value = "Description"
@export var interactable_image = preload("res://assets/icon.svg")

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = interactable_image


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
