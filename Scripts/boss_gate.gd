class_name BossGate
extends StaticBody2D

@onready var animations = $Animations
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animations.play("closed")

func open():
	animations.play("open")
	collision_shape.set_deferred("disabled", true)

func close():
	animations.play("close")
	collision_shape.set_deferred("disabled", false)
