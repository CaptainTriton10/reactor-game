class_name Core

const FUEL_REACTIVITY   = 1.0
const ROOM_TEMPERATURE  = 20.0
const INLET_TEMPERATURE = ROOM_TEMPERATURE
const POWER_RESPONSE    = 0.5
const ROD_SPEED         = 0.1

@export var rod_levels: Array[float] = [1.0]
@export var target_power: float      = 1000000  
@export var target_rod_level: float  = 1.0

var reactivity: float             = 0.0
var heat_generated: float         = 1000.0
var heat_removed_primary: float   = 0.0
var heat_removed_secondary: float = 0.0
var core_temperature: float       = ROOM_TEMPERATURE
var coolant_temperature: float    = ROOM_TEMPERATURE

var controller: AutoRods

func tick(delta: float):
	for i in range(len(rod_levels)):
		rod_levels[i] = move_toward(rod_levels[i], target_rod_level, delta * ROD_SPEED)
	
	var adjustment: float
	if controller.auto_enabled:
		adjustment = controller.target_power(heat_generated, target_power, delta)
		var clamped = clampf(rod_levels[0] - adjustment * delta, 0.1, 0.9)
		rod_levels[0] = clamped
	
	calculate_reactivity()
	
	calculate_heat_generated(delta)
	calculate_heat_removed_primary()
	calculate_heat_removed_secondary()
	
	var heat_transfer_primary = heat_generated - heat_removed_primary
	var heat_transfer_secondary = heat_removed_primary - heat_removed_secondary
	
	core_temperature += (heat_transfer_primary / 10000) * delta
	coolant_temperature += (heat_transfer_secondary / 1000000) * delta

func calculate_reactivity():
	var avg_rod_level = 1.0 - Utils.avg(rod_levels)
	reactivity = avg_rod_level * FUEL_REACTIVITY

func calculate_heat_generated(delta: float):
	var reactivity_s = reactivity * 2.0 - 1.0
	heat_generated = maxf(1000.0, heat_generated * exp(POWER_RESPONSE * reactivity_s * delta))
	
func calculate_heat_removed_primary():
	const heat_transfer = 100000.0    # W/K
	heat_removed_primary = heat_transfer * (core_temperature - coolant_temperature)
	
func calculate_heat_removed_secondary():
	const heat_transfer = 250000.0    # W/K
	heat_removed_secondary = heat_transfer * (coolant_temperature - INLET_TEMPERATURE)
