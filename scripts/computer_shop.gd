extends Node2D
@onready var anim: AnimationPlayer = $Anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("TransIn")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_close_shop_pressed():
	anim.play("TransOut")


func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TransOut":
		queue_free()
