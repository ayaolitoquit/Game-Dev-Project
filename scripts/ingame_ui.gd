extends Control

@onready var counter = $CanvasLayer/Panel/VBoxContainer/Mission1/Counter
@onready var mission_1 = $CanvasLayer/Panel/VBoxContainer/Mission1
@onready var mission_2 = $CanvasLayer/Panel/VBoxContainer/Mission2


func _ready():
	mission_1.show()
	mission_2.hide()

func _process(_delta):
#collect broken pieces
	counter.text = str(Game.paper_collected)
	if Game.paper_collected == 3:
		mission_1.hide()
		mission_2.show()

#######
