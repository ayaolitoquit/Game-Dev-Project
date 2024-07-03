extends Area2D

#signal paper_collected
var body_detected = false
var is_wedphoto_interacted = false
var disappear_duration = 80.0  # Duration to disappear over (in seconds)
var disappear_timer = 0.0
var disappearing = false


func _ready():
	$".".visible = false
	disconnect_signals()
	initialize()
	

func disconnect_signals():
	if  Game.is_connected("wedding_photo_interacted", on_wedding_photo_interacted):
		Game.disconnect("wedding_photo_interacted",on_wedding_photo_interacted)
	if  Game.is_connected("respawn_paper",on_respawn_paper):
		Game.disconnect("respawn_paper",on_respawn_paper)
	if  Game.is_connected("disappear_papers", on_disappear_papers):
		Game.disconnect("disappear_papers", on_disappear_papers)

func initialize():
	if not Game.is_connected("wedding_photo_interacted", on_wedding_photo_interacted):
		Game.connect("wedding_photo_interacted",on_wedding_photo_interacted)
	if not Game.is_connected("respawn_paper",on_respawn_paper):
		Game.connect("respawn_paper",on_respawn_paper)
	if not Game.is_connected("disappear_papers", on_disappear_papers):
		Game.connect("disappear_papers", on_disappear_papers)
	
	set_process(true)


func on_disappear_papers():
	disappearing = true
	disappear_timer = disappear_duration

func _on_body_entered(body):
	if body.name == "Player":
		body_detected = true
		#shader_material.shader = load("res://sample_assets/shaders/asset-library-2D-outline-shader-4-b41ecb704f260c3f04b35b19837ace0f89cb092d/outline.gdshader")
		

func _on_body_exited(body):
	if body.name == "Player":
		body_detected = false
		#shader_material.shader = null

func on_wedding_photo_interacted(_string):
	is_wedphoto_interacted = true
	$".".visible = true

func on_respawn_paper(_something: Array):
	disappearing = false  # Reset disappearing flag
	disappear_timer = 0.0  # Reset disappearance timer
	modulate.a = 1.0  # Reset alpha to 1.0 # Reset alpha to 1.0
	print("disappearing" + str(disappearing))
	print("timer: " + str(disappear_timer) + "  modulate: " + str(modulate.a))

func _process(_delta):
	if is_wedphoto_interacted:
		if body_detected and Input.is_action_just_pressed("interact"):
			Game.emit_signal("paper_is_collected")
			AudioManager.paper_sfx.play()
			queue_free()

	if disappearing and disappear_timer > 0:
		disappear_timer -= _delta
		var progress = 1.0 - (disappear_timer / disappear_duration)
		modulate.a = 1.0 - progress  # Gradually reduce alpha from 1 to 0
		if disappear_timer <= 0:
			queue_free()  # Optionally remove the paper when fully disappeared
