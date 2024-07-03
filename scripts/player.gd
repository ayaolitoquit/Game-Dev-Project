class_name Player extends CharacterBody2D

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel
@onready var level1timer = $Timer
@onready var papers = $"../pieces"
@onready var animations = $animations
@onready var interact_tooltip = $InteractionComponents/Control/Interact_tooltip
@onready var player = $"."

var move_speed : float = 100.0
var paper_complete := false
var paperScene = preload("res://scenes/level_1_paper.tscn")
var input = Vector2.ZERO
var samplestring = ""
var pause_interaction = false
var rings_acquired = false
var journal_1st = false

func _ready():
	update_interactions()
	interact_tooltip.hide()
	if Game.current_level == 1:
		Game.connect("paper_iscomplete", paper_completed) 
		store_initial_item_states()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	set_process_input(true)
	#var player_state = Game._set_state()
	#if player_state:
		#player.position = player_state.position
		#player.velocity = player_state.velocity
		## ...

func _on_dialogic_signal(argument: String):
	if argument == "dialogue_started":
		pause_interaction = true
		set_process_input(false)
	if argument == "dialogue_finished":
		set_process_input(true)
		pause_interaction = false
	if argument == "rings_acquired":
		rings_acquired = true
		Game.emit_signal("mission_counter")

func _process(_delta):
	if not pause_interaction:
		var direction : Vector2 = Vector2.ZERO
		direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		update_animation()
		
		velocity = direction * move_speed
	
	if not pause_interaction:
		if Input.is_action_just_pressed("interact"):
			execute_interaction()

func update_animation():
	if Input.get_action_strength("left") and not pause_interaction:
		animations.play("run_left")
	elif  Input.get_action_strength("right") and not pause_interaction:
		animations.play("run_right")
	elif Input.get_action_strength("up") and not pause_interaction:
		animations.play("run_up")
	elif Input.get_action_strength("down") and not pause_interaction:
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


func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_tooltip.show()
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_tooltip.hide()
		interact_label.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"show_note": 
				Dialogic.VAR.itemlabel = cur_interaction.interact_value
				Dialogic.VAR.itemlabel2 = cur_interaction.interact_value2
				Dialogic.VAR.itemlabel3= cur_interaction.interact_value3
				Dialogic.start("item_interact")
			"show_description": pass
			"interactable": 
				if interact_label.text == str("Wedding Photo"):
					level1timer.start()
					Game.wedding_photo_interacted.emit(str(cur_interaction.interact_value))
					Game.disappear_papers.emit()
				

				if interact_label.text in ["Roses", "Lilies", "Tulips", "Daisies", "Dahlias","Irises", "Sunflowers"]:
					Dialogic.VAR.itemlabel = cur_interaction.interact_value
					Dialogic.start("interactable_item")

				if interact_label.text == str("Flashlight"):
					Game.emit_signal("flashlight_acquired")
					Dialogic.VAR.itemlabel = cur_interaction.interact_value
					Dialogic.start("interactable_item")

			"next_level":
				if interact_label.text == str("Gate"):
					print("is rings " + str(rings_acquired))
					print(str(Dialogic.VAR.rings))
					Dialogic.VAR.rings = rings_acquired
					Dialogic.start("progress_next_level")
				else:
					Dialogic.start("progress_next_level")
			"journal_hint":
				Dialogic.start("journal_hint")
				if not journal_1st:
					Game.emit_signal("mission_counter")
					journal_1st = true
			"compartment":
				Dialogic.start("compartment")
			"mirror":
				Dialogic.VAR.item = cur_interaction.interact_label
				Dialogic.start("level2cutscene")
				#if interact_label.text == str("Mirror"):
					#Dialogic.VAR.itemlabel = cur_interaction.interact_value
					#Dialogic.start("interactable_item")
					#
					#print("nyare sayo beh")

##############################################################
func paper_completed():
	paper_complete = true
	level1timer.stop()

var initial_item_states = []

func store_initial_item_states():
	## Store the initial state and position of each item
	if Game.current_level == 1:
		for item in papers.get_children():
			initial_item_states.append({
				"scene": paperScene,
				"position": item.global_position
			})

func _on_timer_timeout():
	if paper_complete == false:
		print("timeout!")
		Game.paper_collected = 0
		await get_tree().create_timer(3.0).timeout
		Game.level1paper_reset.emit()
		Game.respawn_paper.emit(initial_item_states)
		Game.wedding_photo_interacted.emit(samplestring)
		level1timer.start()
		

