extends StaticBody2D

var rotation_speed: float = 1
var direction = -1
@export var clockwise_rotation: bool = false
@onready var animations = $Animations
@onready var contact_box = $ContactBox

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("fire_spin")
	if clockwise_rotation:
		direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animations.rotate(rotation_speed * direction * delta)
	contact_box.rotate(rotation_speed * direction * delta)
