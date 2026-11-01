extends Interactable

@onready var anim_player = $"../AnimationPlayer"

var opened = false

func on_press() -> void:
	if opened:
		anim_player.play("CoverLift", -1.0, -1.0, true)
	else:
		anim_player.play("CoverLift")
		
	opened = !opened
