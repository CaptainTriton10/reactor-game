extends Interactable

func pressed() -> void:
	print("Pressed")

func held() -> void:
	print("Held")
	
func released() -> void:
	print("Released")

func _init() -> void:
	type = InteractionType.HOLD
