extends Control

@onready var counter = $CanvasLayer/Panel/VBoxContainer/Mission1/Counter
@onready var mission_1 = $CanvasLayer/Panel/VBoxContainer/Mission1
@onready var mission_2 = $CanvasLayer/Panel/VBoxContainer/Mission2

static var paper_collected := 0

func _ready():
	Game.connect("paper_iscollected", collectpaper)
	mission_1.show()
	mission_2.hide()

func _process(_delta):
#collect broken pieces
	if paper_collected == 3:
		mission_1.hide()
		mission_2.show()

func collectpaper():
	paper_collected += 1
	counter.text = str(paper_collected)
