extends Node
class_name Display1

enum Type {
	POWER,
	TEMP,
	VALUE,
	NONE
}

@export var label: Label
@export var value: float = 0.0
@export var value_name: String
@export var type: Type

const UPDATE_PERIOD = 0.25
var current_period =  0.0

func _ready() -> void:
	add_to_group("Display")

func _process(delta: float) -> void:
	current_period += delta
	
	if current_period >= UPDATE_PERIOD:
		label.text = value_with_units()
		current_period = 0
		
func value_with_units() -> String:
	match type:
		Type.POWER:
			if value >= 1000000:
				return "%.1f MW" % [value / 1000000]
			elif value >= 1000:
				return "%.1f kW" % [value / 1000]
			else:
				return "%.1f W" % value
				
		Type.TEMP:
			return "%.1f °C" % value
		
		Type.VALUE:
			return "%.1f" % value
		
		_:
			return "None"
