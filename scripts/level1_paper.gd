extends Area2D

#signal paper_collected
var body_detected = false

func _on_body_entered(body):
	if body.name == "Player":
		body_detected = true
		

func _on_body_exited(body):
	if body.name == "Player":
		body_detected = false

func _process(delta):
	if body_detected and Input.is_action_just_pressed("interact"):
		print("nakuha")
		Game.emit_signal("paper_iscollected")
		queue_free()
