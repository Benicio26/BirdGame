extends Node3D
@onready var camera_3d: Camera3D = $player/head/Camera3D
@onready var object_detection_ray: RayCast3D = $player/head/Camera3D/object_detection_ray
# game states vars


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	object_detection()


func object_detection():
	# Crosshair Obejct Detection
	if Input.is_action_just_pressed("object_click") and object_detection_ray.is_colliding():
		var encountered_object = object_detection_ray.get_collider()
		# Check what object is being collided with
		if encountered_object.is_in_group("OpensShop"):
			var computer_shop = preload("res://scenes/computer_shop.tscn")
			var computer_shop_node = computer_shop.instantiate()
			add_child(computer_shop_node)
