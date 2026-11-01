@tool
extends Node

@export var action: String = "None":
	set(value):
		action = value
		
		var switch = get_node_or_null("Switch1/Pad/StaticBody3D")
		if switch != null:
			switch.action = value
