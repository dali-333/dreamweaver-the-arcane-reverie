extends Node2D

@onready var door_sprite = $door  # Reference to the door's AnimatedSprite2D
@onready var door_collision = $door/door/CollisionShape2D  # Reference to the door's CollisionShape2D

@onready var button_sprite = $button  # Reference to the button's AnimatedSprite2D
@onready var button_area = $button/area2d  # Reference to the button's Area2D
@onready var is_door_open = false  # Track door state

func _ready():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("enter" + body.name)
	if not is_door_open:
		is_door_open = true
		door_sprite.play("run")  # Play door opening animation
		button_sprite.play("run")  # Play button press animation
		door_collision.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("exit")
	if is_door_open:
		is_door_open = false
		door_collision.set_deferred("disabled", false)  # Re-enable collision
		door_sprite.play_backwards("run")  # Play door closing animation
		button_sprite.play_backwards("run")  # Play button release animation
