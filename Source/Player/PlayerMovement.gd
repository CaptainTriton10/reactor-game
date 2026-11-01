extends CharacterBody3D

const WALK_SPEED = 3.5
const SPRINT_SPEED = 7.0

const JUMP_VELOCITY = 6.0
const GRAVITY = Vector3(0.0, -25.0, 0.0)

var speed = WALK_SPEED
const acceleration = 25.0
const deceleration = 25.0

@export var sensitivity = 0.1
@export var camera: Camera3D
@export var enable_mouse: bool

var rotation_x := 0.0
var rotation_y := 0.0

var mouse_locked = false

func _ready() -> void:
	if !enable_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	SignalBus.set_mouse_motion.connect(set_mouse_motion)

func set_mouse_motion(value: bool):
	mouse_locked = !value

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("sprint"):
		speed = SPRINT_SPEED
		
	if Input.is_action_just_released("sprint"):
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)

	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !enable_mouse and !mouse_locked:
		rotation_y -= event.relative.x * sensitivity
		rotation_x -= event.relative.y * sensitivity
		
		rotation_x = clamp(rotation_x, -85, 85)
		
		rotation_degrees.y = rotation_y
		camera.rotation_degrees.x = rotation_x
