extends Interactable

@export var anim_player: AnimationPlayer

var opened = false

func pressed() -> void:
	if !opened:
		anim_player.play("CoverLift")
		opened = true
	else:
		anim_player.play("CoverLift", -1.0, -1.0, true)
		opened = false
