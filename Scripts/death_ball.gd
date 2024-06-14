extends AnimatedSprite2D

@export var direction_x: float = 0.0
@export var direction_y: float = 0.0
@export var speed: float = 80.0

var direction: Vector2

func _ready():
	direction = Vector2(direction_x, direction_y).normalized()
	play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
