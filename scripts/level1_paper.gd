extends Area2D

#signal paper_collected
var body_detected = false
var is_wedphoto_interacted = false
var disappear_duration = 20.0  # Duration to disappear over (in seconds)
var disappear_timer = 0.0
var disappearing = false

func _ready():
	initialize()
	disappear_timer = disappear_duration

func initialize():
	if not Game.is_connected("wedding_photo_interacted", wedphoto_interacted):
		Game.connect("wedding_photo_interacted",wedphoto_interacted)
	if not Game.is_connected("respawn_paper",papers_respawn):
		Game.connect("respawn_paper",papers_respawn)
	if not Game.connect("disappear_papers", paper_disappear):
		Game.connect("disappear_papers", paper_disappear)
	
	set_process(true)


func paper_disappear():
	disappearing = true

func _on_body_entered(body):
	if body.name == "Player":
		body_detected = true

func _on_body_exited(body):
	if body.name == "Player":
		body_detected = false

func wedphoto_interacted():
	is_wedphoto_interacted = true

func papers_respawn(_something: Array):
	queue_free()

func _process(_delta):
	if is_wedphoto_interacted:
		if body_detected and Input.is_action_just_pressed("interact"):
			Game.emit_signal("paper_iscollected")
			queue_free()

	if disappearing and disappear_timer > 0:
		disappear_timer -= _delta
		var progress = 1.0 - (disappear_timer / disappear_duration)
		modulate.a = 1.0 - progress  # Gradually reduce alpha from 1 to 0
		if disappear_timer <= 0:
			queue_free()  # Optionally remove the paper when fully disappeared
