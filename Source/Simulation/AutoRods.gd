class_name AutoRods

var auto_enabled: bool = false

var max_rod_speed = 0.1
var controller_strength = 0.01
var error: float
var adjustment: float

var kp = 0.0002
var kd = 0.001

var previous_error = 0.0
var has_error = false

func _on_auto_rods_set(value: bool):
	auto_enabled = value

func target_power(power: float, target: float, delta: float) -> float:
	error = target - power
	
	var derivative = 0.0
	if has_error:
		derivative = (error - previous_error) / delta
	
	previous_error = error
	has_error = true
	
	var command = kp * error + kd * derivative
	
	# Adjustment is minus because the rod level is inversely proportional to power
	return clampf(command, -max_rod_speed, max_rod_speed)
