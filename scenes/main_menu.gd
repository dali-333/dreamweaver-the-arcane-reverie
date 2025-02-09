extends Control

@onready var play: TextureButton = %Play
@onready var quit: TextureButton = %Quit
@export var level0: PackedScene
func go_to_level_0():
	get_tree().change_scene_to_packed(level0)

func exit_game():
	get_tree().exit()
	
func _ready() -> void:
	play.pressed.connect(go_to_level_0)
	quit.pressed.connect(exit_game)
