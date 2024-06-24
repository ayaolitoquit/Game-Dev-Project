extends Area2D

#signal paper_collected
var body_detected = false
var is_wedphoto_interacted = false

func _ready():
	Game.connect("wedding_photo_interacted", wedphoto_interacted)
	

func _on_body_entered(body):
	if body.name == "Player":
		body_detected = true

func _on_body_exited(body):
	if body.name == "Player":
		body_detected = false

func wedphoto_interacted():
	is_wedphoto_interacted = true

func _process(_delta):
	if is_wedphoto_interacted:
		if body_detected and Input.is_action_just_pressed("interact"):
			Game.emit_signal("paper_iscollected")
			queue_free()
