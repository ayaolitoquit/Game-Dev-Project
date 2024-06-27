extends Node2D

var on_mirror_body_detected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Game.current_level = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_mirror_body_entered(body):
	if body.name == "Player":
		on_mirror_body_detected = true


func _on_mirror_body_exited(body):
	if body.name == "Player":
		on_mirror_body_detected = false
