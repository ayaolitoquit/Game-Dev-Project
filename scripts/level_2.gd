extends Node2D

var on_mirror_body_detected = false
# Called when the node enters the scene tree for the first time.
@onready var player = $Player


func _ready():
	Game.current_level = 2
	Dialogic.signal_event.connect(on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_dialogic_signal(argument: String):
	if argument == "teleport":
		player.global_position = Vector2(1441,103)

func _on_mirror_body_entered(body):
	if body.name == "Player":
		on_mirror_body_detected = true
		if Input.is_action_just_pressed("interact"):
			Dialogic.start("interactable_item")
			#input CUTSCENES
			
		#player.global_position = Vector2(1441,103)


func _on_mirror_body_exited(body):
	if body.name == "Player":
		on_mirror_body_detected = false