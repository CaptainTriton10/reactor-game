extends Node
class_name SimulationInput

func _ready() -> void:
	SignalBus.core_scram.connect(_on_core_scram)

func _on_core_scram():
	core.rod_levels[0] = 1.0

func _init(_core: Core) -> void:
	core = _core
