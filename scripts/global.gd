extends Node

# Global dictionary for birds, 
@onready var birds = {
	0 : {
		"name" : "Parakeet",
		"color" : "red",
		"lifespan" : randi_range(7,15),
	},
	1 : {
		"name" : "Cockatiel",
		"color" : "red",
		"lifespan" : randi_range(15,30),
	},
	2 : {
		"name" : "Dove",
		"color" : "red",
		"lifespan" : randi_range(8,15),
	},
	3 : {
		"name" : "Canary",
		"color" : "red",
		"lifespan" : randi_range(9,10),
	}
}
# Create multiple "levels" of birds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
