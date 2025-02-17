extends CharacterBody3D

# node vars
@onready var head: Node3D = $head
@onready var body_crouched: CollisionShape3D = $body_crouched
@onready var body: CollisionShape3D = $body
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var camera_3d: Camera3D = $head/Camera3D
@onready var object_detection_ray: RayCast3D = $head/Camera3D/object_detection_ray
@onready var computer_shop = preload("res://scenes/computer_shop.tscn")
@onready var computer_shop_node = computer_shop.instantiate()

# speed vars
var current_speed = 5.0
const walking_speed = 5.0
const sprint_speed = 8.0
const crouch_speed = 3.0

# movement vars
const jump_velocity = 4.5
var crouch_depth = -0.5
var lerp_speed = 10
var air_lerp_speed = 3
@export var is_locked = false

# input vars
const mouse_sens = 0.15
const walking_fov : float = 75
const sprint_fov : float = 100
var direction = Vector3.ZERO

# game states vars
var encountered_object = null


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	#movement states
	if Input.is_action_pressed("crouch"):
		current_speed = crouch_speed
		head.position.y = lerp(head.position.y, 1.8 + crouch_depth, delta * lerp_speed)
		body_crouched.disabled = false
		body.disabled = true
	elif !ray_cast_3d.is_colliding():
		body_crouched.disabled = true
		body.disabled = false
	else:
		head.position.y = lerp(head.position.y, 1.8, delta * lerp_speed)
		if Input.is_action_pressed("sprint"):
			current_speed = sprint_speed 
			camera_3d.fov = lerp(camera_3d.fov, sprint_fov, delta * lerp_speed)
		else:
			current_speed = walking_speed
			camera_3d.fov = lerp(camera_3d.fov, walking_fov, delta * lerp_speed)
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if is_on_floor():
		direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * lerp_speed)
	else:
		if input_dir != Vector2.ZERO:
			direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * air_lerp_speed)

	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
		
	move_and_slide()
	
	
#func object_detection():
	## crosshair detection
	## Pretty sure this code sucks tho, I will probably need to isolate this in a function or smth so it is much more adaptable to the thing that it will be colliding with
	#if Input.is_action_just_pressed("object_click") and object_detection_ray.is_colliding():
		#encountered_object = object_detection_ray.get_collider()
		#if encountered_object.is_in_group("OpensShop") and !shop_menu_opened:
			#camera_3d.add_child(computer_shop_node)
			

func _input(event):
	if event is InputEventMouseMotion:
	# head rotation
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	if Input.is_action_just_pressed("quit"):
	# pressing quits
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
