@tool
extends Node

@export var action: String = "None":
	set(value):
		action = value
		
		var wheel = get_node_or_null("Wheel 1/Ring/StaticBody3D")
		if wheel != null:
			wheel.action = value

@export var degrees_per_unit: float = 3.6:
	set(value):
		degrees_per_unit = value
		
		var wheel = get_node_or_null("Wheel 1/Ring/StaticBody3D")
		if wheel != null:
			wheel.degrees_per_unit = value
