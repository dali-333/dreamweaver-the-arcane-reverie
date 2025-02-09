class_name GameManager 
extends Node 

@onready var player = get_tree().get_first_node_in_group("player")

var score = 0:
	set(value):
		score += value
		if score + value > 3:
			score = 3
			Signals.start_lucidity.emit()
		if score == 3:
			Signals.start_lucidity.emit()

func _ready() -> void:
	Signals.end_lucidity.connect(
		func(): score = 0
	)
	Signals.score_changed.connect(
		func(amount): score += amount
	)
