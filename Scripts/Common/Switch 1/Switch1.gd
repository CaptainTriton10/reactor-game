extends Interactable

class_name Wheel1

@onready var pad: MeshInstance3D = $".."
@onready var screen_light: AreaLight3D = $"../../../AreaLight3D"

var on_tex: Texture2D = load("res://Resources/Textures/SwitchOn.png")
var off_tex: Texture2D = load("res://Resources/Textures/SwitchOff.png")

var value: bool = true
@export var action: String

func _ready() -> void:
	update_button(value)
			
func update_button(is_on: bool) -> void:
	var mat = pad.get_active_material(0)
		
	if mat is BaseMaterial3D:
		if is_on:
			mat.emission_texture = on_tex
			screen_light.light_color = Color.hex(0x7dff9eff)
			
		else:
			mat.emission_texture = off_tex
			screen_light.light_color = Color.hex(0xff5a2cff)
			
func on_press() -> void:
	update_button(!value)
	value = !value
	
	SignalBus.interaction.emit(action, value)
