extends Node

var paper_collected: int = 0
var is_wedphoto_interacted = false
var current_level = 1

signal paper_is_collected
signal paper_iscomplete
signal wedding_photo_interacted(string)
signal items_interacted(string)
signal level1paper_reset
signal respawn_paper(initial_item_states: Array)
signal disappear_papers
signal progress_next_level
signal broken_tile
signal mission_counter 
signal flashlight_acquired
signal reset_level
#func _get_state():
	#var state = {
		#"position": position,
		#"velocity": velocity,
		## Add other state variables as needed
	#}
	## Save the state to a file or a singleton
	#Game._get_state(state)
#
#func _set_state(state):
	#position = state["position"]
	#velocity = state["velocity"]


