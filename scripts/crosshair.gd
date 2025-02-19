extends CenterContainer
@onready var object_detection_ray: RayCast3D = $"../../object_detection_ray"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# crosshair vars
@export var dot_radius : float = 1.0 
@export var dot_color : Color = Color.WHITE

#speed vars
const lerp_speed = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	if object_detection_ray.is_colliding():
		var encountered_object = object_detection_ray.get_collider()
		if encountered_object.is_in_group("OpensShop"):
			draw_circle(Vector2(0,0), 5.0, dot_color)
		else:
			draw_circle(Vector2(0,0), 1.0, dot_color)
	else:
		draw_circle(Vector2(0,0), 1.0, dot_color)
