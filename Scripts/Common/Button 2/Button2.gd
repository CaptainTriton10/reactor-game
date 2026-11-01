extends Interactable

class_name Button2

@onready var anim_player = $"../AnimationPlayer"

@export var action: String

var value: bool = false

func _ready() -> void:
	update_button(value)

func update_button(is_on: bool) -> void:
	if is_on:
		anim_player.play("ButtonPress")
	else:
		anim_player.play("ButtonPress", -1.0, -1.0, true)

func on_press() -> void:
	update_button(!value)
	value = true
	
	SignalBus.interaction.emit(action, value)
