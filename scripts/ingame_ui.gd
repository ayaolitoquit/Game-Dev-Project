extends Control

@onready var counter = $CanvasLayer/Panel/VBoxContainer/Mission1/Counter
@onready var mission_1 = $CanvasLayer/Panel/VBoxContainer/Mission1
@export var quests := PackedStringArray()

static var paper_collected := 0
static var paper_complete := false
var is_wedphoto_interacted = false
var quest_counter = 0



func _ready():
	Game.connect("paper_iscollected", collectpaper)
	Game.connect("wedding_photo_interacted", wedphoto_interacted)
	mission_1.visible = false
	mission_1.text = quests[quest_counter]

func _process(_delta):
	if is_wedphoto_interacted:
		mission_1.visible = true
	
#collect broken pieces
	if paper_collected == 3:
		Game.emit_signal("paper_iscomplete")
		quest_completed()
		print(quest_counter)
		mission_1.text = quests[quest_counter]
		counter.visible = false
		paper_collected = 0

func collectpaper():
	paper_collected += 1
	counter.text = str(paper_collected) + "/9"

func wedphoto_interacted():
	is_wedphoto_interacted = true

func quest_completed():
	quest_counter += 1
