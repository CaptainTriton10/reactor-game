extends SignalReceiver

@onready var emitter: MeshInstance3D = $Light1/Emitter
@onready var light: AreaLight3D = $AreaLight

func effect(value: Variant):
	if value is bool:
		var mat = emitter.get_active_material(0)
		mat.emission_enabled = value
		
		light.light_energy = 9.0 if value else 0.0
