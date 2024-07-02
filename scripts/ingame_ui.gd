extends Control

@export var quests := PackedStringArray()

@onready var counter = $CanvasLayer/Panel/MarginContainer/VBoxContainer/HBoxContainer/Counter
@onready var mission_1 = $CanvasLayer/Panel/MarginContainer/VBoxContainer/HBoxContainer/Mission1

static var paper_collected := 0
static var paper_complete := false
var is_wedphoto_interacted = false
var quest_counter = 0

func _ready():
	Game.connect("paper_is_collected", on_paper_is_collected)
	Game.connect("wedding_photo_interacted", on_wedding_photo_interacted)
	Game.connect("items_interacted", on_items_interacted)
	Game.connect("level1paper_reset", on_level1paper_reset)
	Game.connect("progress_next_level", on_progress_next_level)
	Game.connect("mission_counter", on_mission_counter)
	
	mission_1.text = quests[quest_counter]
	print("level: " + str(Game.current_level))
	
	if Game.current_level != 1:
		mission_1.show() 

func _process(_delta):
	if is_wedphoto_interacted:
		mission_1.show()
	
	#collect broken pieces
	if paper_collected == 9:
		paper_completed()

func on_paper_is_collected():
	paper_collected += 1
	counter.text = str(paper_collected) + "/9"

func on_wedding_photo_interacted(label):
	Dialogic.VAR.itemlabel = label
	Dialogic.start("interactable_item")
	is_wedphoto_interacted = true
	counter.show()

func on_items_interacted(label1, label2, label3):
	Dialogic.VAR.itemlabel = label1
	Dialogic.VAR.itemlabel2 = label2
	Dialogic.VAR.itemlabel3= label3
	Dialogic.start("item_interact")

func on_level1paper_reset():
	paper_collected = 0
	counter.text = str(paper_collected) + "/9"
	Dialogic.start("alert")
	Dialogic.VAR.level = "level1"

func on_progress_next_level():
	Dialogic.start("progress_next_level")

func paper_completed():
	Game.emit_signal("paper_iscomplete")
	quest_counter += 1
	mission_1.text = quests[quest_counter]
	counter.hide()
	paper_collected = 0
	Dialogic.start("next_level")
	Dialogic.VAR.level = "level1"

func on_mission_counter():
	quest_counter += 1
	mission_1.text = quests[quest_counter]

