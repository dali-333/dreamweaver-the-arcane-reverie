extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.scene_changed.connect(
		func():
			start(30)
	)
