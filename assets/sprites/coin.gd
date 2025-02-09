extends Area2D

@export var game_manager : GameManager


func _on_body_entered(body: Node2D) -> void:
	Signals.score_changed.emit(1)
	NightTimer.start(30)
	queue_free()
