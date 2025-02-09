extends TextureProgressBar


@onready var timer = get_tree().get_first_node_in_group("nighttimer")

func _process(delta: float) -> void:
	value = 30 - timer.time_left
