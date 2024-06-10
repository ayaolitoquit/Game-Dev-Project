class_name Player extends CharacterBody2D

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel

var move_speed : float = 100.0
var paper_complete := false

func _ready():
	update_interactions()
	Game.connect("paper_iscomplete", paper_completed)
	
func _process(_delta):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	pass
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

func _physics_process(_delta):
	move_and_slide()


#Interaction (items)
#################################

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"show_note": print(cur_interaction.interact_value)
			"show_description": print(cur_interaction.interact_value)
			"interactable": 
				if paper_complete:
					print("paper completed - show code")
				else:
					print("di pa tapos!")
				

func paper_completed():
	paper_complete = true
