extends Node

var paper_collected: int = 0
var is_wedphoto_interacted = false
var current_level = 1

signal paper_is_collected
signal paper_iscomplete
signal wedding_photo_interacted
signal items_interacted(string)
signal level1paper_reset
signal respawn_paper(initial_item_states: Array)
signal disappear_papers
signal progress_next_level
