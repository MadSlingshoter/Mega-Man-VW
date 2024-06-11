extends Sprite2D

@export var SPEED = 1.5
@export var DAMAGE = 1

var direction : bool
@onready var visible_on_screen_notifier = $VisibleOnScreenNotifier2D

var time = 0.0

func init(d):
	direction = d
	flip_h = d

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# needed because otherwise 
	if time > 0:
		if !visible_on_screen_notifier.is_on_screen():
			queue_free()
	time += _delta
	
	# Shot flies in the correct direction
	if direction:
		position.x -= SPEED
	else:
		position.x += SPEED
	
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_area_entered(area):
	area.get_parent().damage2(DAMAGE)
	queue_free()
