extends Sprite2D


func _physics_process(delta):
	modulate.a = lerp(modulate.a, 0.0, 0.1)  # Ensure 0.0 instead of just 0
	if modulate.a < 0.01:
		queue_free()
