extends CharacterBody2D


@export var SPEED :float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_y_pos

func _ready():
	start_y_pos = global_position.y


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x = 0
		velocity.y = SPEED
	else:
		velocity.x = -SPEED
		velocity.y = 0
	
	if (global_position.y - start_y_pos > 270):
		queue_free()
	
	move_and_slide()
