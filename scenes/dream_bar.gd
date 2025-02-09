extends TextureProgressBar

func _ready() -> void:
	Signals.score_changed.connect(
		func(amount):
			value += amount
			print("amount : ", amount)
			print("value : ", value)

	)
