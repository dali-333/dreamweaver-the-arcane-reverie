extends AnimatedSprite2D

@export var next_level : PackedScene
@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Signals.scene_changed.emit()
		get_tree().change_scene_to_packed(next_level)
