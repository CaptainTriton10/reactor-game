class_name Turbines

const THERMAL_EFFICIENCY = 0.3
const TURBINE_EFFICIENCY = 0.7

@export var turbine_bypass = 0.0

var thermal_power: float = 0.0
var electrical_power: float = 0.0

func tick(_delta: float, core: Core):
	calculate_thermal_power(core.heat_removed_primary)
	calculate_power_generated(thermal_power)

func calculate_thermal_power(power: float):
	thermal_power = power * THERMAL_EFFICIENCY
	
func calculate_power_generated(power: float):
	electrical_power = power * TURBINE_EFFICIENCY * (1.0 - turbine_bypass)
