extends Node

@export var raycast: RayCast3D

var current_target: Interactable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_target: Interactable = null
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		
		if collider is Interactable:
			new_target = collider
				
	if new_target != current_target:
		current_target = new_target
		
	if new_target != null:
		if Input.is_action_pressed("interact"):
			current_target.while_held(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_target == null:
		return 
		
	if event.is_action_pressed("interact"):
		current_target.on_press()
					
	if event.is_action_released("interact"):
		current_target.on_release()
