extends AnimatedSprite2D
## AnimatedSprite2D for the pulsing balls released when the player of a boss dies.

## The horizontal movement direction.
@export var direction_x: float = 0.0
## The vertical movement direction.
@export var direction_y: float = 0.0
## The speed of the pulsing ball. 80 for the slow and 160 for the fast.
@export var speed: float = 80.0

# The direction of the pulsing ball
var _direction: Vector2

# Calculates the direction and starts the animation.
func _ready():
	_direction = Vector2(direction_x, direction_y).normalized()
	play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves the pulsing ball
func _process(delta):
	position += _direction * speed * delta

## Callback to remove the pulsing ball when not on screen anymore.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
