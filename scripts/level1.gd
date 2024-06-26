extends Node2D

var instanced_item_scene = null
const LEVEL_1_PAPER = preload("res://scenes/level_1_paper.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("respawn_paper", respawn_papers)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func respawn_papers(initial_item_states: Array):
	for item_state in initial_item_states:
		var scene = item_state["scene"]
		var position = item_state["position"]
		
		# Check if the scene is a PackedScene and instance it
		if scene is PackedScene:
			var instance = scene.instantiate()
			if instance:
				# Set the instance position
				instance.global_position = position
				
				# Add the instance to the current scene tree
				add_child(instance)
				instance.call("initialize")
######## DI NAGANA YUNG INTERACT SA INSTANCED PAPERS!!!!!!! ######################
			else:
				print("Failed to instantiate the scene.")
		else:
			print("Invalid scene data.")





	#for item_data in get_tree().get_nodes_in_group("papers"):
		#var item_instance = item_data["scene"].instantiate()
		#item_instance.global_position = item_data["position"]
		## Ensure the item is added to the "Item" group
		#item_instance.add_to_group("Item")
	
	# Load and instance a new scene
	#var item_scene = load("res://scenes/level_1_paper.tscn")
	#instanced_item_scene = item_scene.instantiate()
	#add_child(instanced_item_scene)
	#
	#for i in range(instanced_item_scene.get_child_count()):
		#var item_instance = instanced_item_scene.get_child(i)
		#item_instance.global_position = initial_item_states[i]["position"]
		## Ensure the item is added to the "Item" group
		#item_instance.add_to_group("Item")
