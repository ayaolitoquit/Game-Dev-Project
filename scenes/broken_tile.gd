extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready():
	pass
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			animation_player.play("broken_tile")
			await animation_player.animation_finished
			Game.emit_signal("broken_tile")
			print("signal broken")
			queue_free()
		else:
			animation_player.play("idle")

#func _on_body_entered(body):
	#print("pumasok")
	#print(body)
	#if body.get_parent().name == "Player":
		#print("may pumasok")
		#animation_player.play("broken_tile")
