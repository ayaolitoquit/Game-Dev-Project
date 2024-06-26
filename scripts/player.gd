class_name Player extends CharacterBody2D

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel
@onready var level1timer = $Timer
@onready var papers = $"../pieces"
@onready var animations = $animations
@onready var interact_tooltip = $InteractionComponents/Control/Interact_tooltip



var move_speed : float = 100.0
var paper_complete := false
var paperScene = preload("res://scenes/level_1_paper.tscn")
var input = Vector2.ZERO

func _ready():
	update_interactions()
	interact_tooltip.visible = false
	if Game.current_level == 1:
		Game.connect("paper_iscomplete", paper_completed) 
		store_initial_item_states()
	
	
func _process(_delta):
	
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	update_animation()
	
	velocity = direction * move_speed
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()

func update_animation():
	if Input.get_action_strength("left"):
		animations.play("run_left")
	elif  Input.get_action_strength("right"):
		animations.play("run_right")
	elif Input.get_action_strength("up"):
		animations.play("run_up")
	elif Input.get_action_strength("down"):
		animations.play("run_down")
	else:
		animations.play("idle")

func _physics_process(_delta):
	move_and_slide()


#Interaction (items)
#################################
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()
	#interact_tooltip.visible = true


func _on_interaction_area_area_exited(area):
	#interact_tooltip.visible = false
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_tooltip.visible = true
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_tooltip.visible = false
		interact_label.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"show_note": 
				Game.items_interacted.emit(str(cur_interaction.interact_value), str(cur_interaction.interact_value2), str(cur_interaction.interact_value3))
				if interact_label.text == str("Wedding Photo"):
					level1timer.start()
					Game.disappear_papers.emit()
					Game.wedding_photo_interacted.emit()
			"show_description": pass
			"interactable": 
				###DONT KNOW WHATS THIS
				if paper_complete:
					print("paper completed - show code")
				else:
					print("di pa tapos!")
			"next_level":
				Game.progress_next_level.emit()

##############################################################
func paper_completed():
	paper_complete = true
	level1timer.stop()

var initial_item_states = []

func store_initial_item_states():
	## Store the initial state and position of each item
	for item in papers.get_children():
		initial_item_states.append({
			"scene": paperScene,
			"position": item.global_position
		})
		print(initial_item_states)
	pass

func _on_timer_timeout():
	print("timeout!")
	if paper_complete == false:
		Game.paper_collected = 0
		await get_tree().create_timer(3.0).timeout
		Game.level1paper_reset.emit()
		#respawn_papers()
		Game.respawn_paper.emit(initial_item_states)
		Game.wedding_photo_interacted.emit()
		level1timer.start()
		

