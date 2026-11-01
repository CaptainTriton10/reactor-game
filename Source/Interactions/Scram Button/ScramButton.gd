extends Interactable

@export var anim_player: AnimationPlayer
var locked = false

func pressed() -> void:
	if !locked:
		anim_player.play("ButtonPress")
		SignalBus.core_scram.emit()
		locked = true
