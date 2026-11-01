extends Node

class_name SignalReceiver

@export var action: String

func _ready() -> void:
	SignalBus.interaction.connect(_on_receive)

func _on_receive(action_name: String, value: Variant):
	if action_name == action:
		effect(value)
	
func effect(value: Variant):
	pass
