extends Node2D

@onready var player_flashlight = $Player/player_flashlight

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("flashlight_acquired", on_flashlight_acquired)

func on_flashlight_acquired():
	player_flashlight.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
