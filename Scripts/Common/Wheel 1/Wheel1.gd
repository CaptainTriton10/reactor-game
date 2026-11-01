extends Interactable

class_name Switch1

const TURN_SPEED = 0.2

@onready var ring: Node3D = $".."

@export var action: String
@export var degrees_per_unit = 3.6

var on_tex: Texture2D = load("res://Resources/Textures/SwitchOn.png")
var off_tex: Texture2D = load("res://Resources/Textures/SwitchOff.png")

var value: float = 0.0
var total_turn: float = 0.0

var mouse_motion: Vector2 = Vector2.ZERO 

func _ready() -> void:
	update(value)
			
func update(angle: float) -> void:
	ring.rotate_object_local(Vector3(0.0, 1.0, 0.0), angle)

func on_press() -> void:
	SignalBus.set_mouse_motion.emit(false)
	
func while_held(delta: float) -> void:
	var angle = -mouse_motion.y * delta * TURN_SPEED
	
	update(angle)
	mouse_motion = Vector2.ZERO
	
	var degrees = rad_to_deg(-angle)
	SignalBus.interaction.emit(action, degrees / degrees_per_unit)

func on_release() -> void:
	SignalBus.set_mouse_motion.emit(true)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_motion = event.relative
