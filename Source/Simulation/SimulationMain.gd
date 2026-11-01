extends Node

var turbines: Turbines
var core: Core

func _ready() -> void:
	turbines = Turbines.new()
	core = Core.new()
	core.controller = AutoRods.new()
	
	SignalBus.interaction.connect(_on_interaction)

func _on_interaction(action_name: String, value: Variant) -> void:
	match action_name:
		"CoreAutoToggle":
			core.controller.auto_enabled = value as bool
		"CoreScram":
			core.controller.auto_enabled = false
			core.target_rod_level = 1.0
		"ControlRodValue":
			core.target_rod_level = clampf(core.target_rod_level - value as float, 0.0, 1.0)

func _process(delta: float) -> void:
	core.tick(delta)
	turbines.tick(delta, core)
	
	update_displays()

func update_displays():
	var displays = get_tree().get_nodes_in_group("Display")
	for display in displays:
		if display is Display1:
			match display.value_name:
				"heat_generated":
					update_display(display, core.heat_generated)
					
				"thermal_power":
					update_display(display, turbines.thermal_power)
					
				"electrical_power":
					update_display(display, turbines.electrical_power)
					
				"core_temp":
					update_display(display, core.core_temperature)
					
				"coolant_temp":
					update_display(display, core.coolant_temperature)
					
				"rod_levels":
					update_display(display, Utils.avg(core.rod_levels) * 100)
					
				"none":
					update_display(display, -1.0)
					
				_:
					print("Unknown display %s" % display)

func update_display(display: Display1, value: float):
	display.value = value
