extends Camera2D

signal transition_finished()
signal gate_transition_finished()

# divide by 3 because zoom 3
const HORI_SCREEN_SIZE = 256
const VERT_SCREEN_SIZE = 240
@export var TRANSITION_TIME: float = 1.0
@export var GATE_TRANSITION_TIME: float = 4.0

func spawn_limits(new_limit_top: int, new_limit_left: int, new_limit_bottom: int, new_limit_right: int) -> void:
	limit_top = new_limit_top
	limit_left = new_limit_left
	limit_bottom = new_limit_bottom
	limit_right = new_limit_right

func screen_transition(new_limit_top: int, new_limit_left: int, new_limit_bottom: int, new_limit_right: int, transition_dir: Global.TransitionDir):
	# set limits before transitions for smoother transitions
	if transition_dir == Global.TransitionDir.right:
		limit_left = limit_right - HORI_SCREEN_SIZE
		limit_top = new_limit_top
		limit_bottom = new_limit_bottom
		var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
		tween.finished.connect(_on_transition_finished.bind(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right))
		tween.tween_property(self, "limit_left", new_limit_left, TRANSITION_TIME)
		tween.tween_property(self, "limit_right", new_limit_left + HORI_SCREEN_SIZE, TRANSITION_TIME)
	elif transition_dir == Global.TransitionDir.left:
		limit_right = limit_left + HORI_SCREEN_SIZE
		limit_top = new_limit_top
		limit_bottom = new_limit_bottom
		var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
		tween.finished.connect(_on_transition_finished.bind(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right))
		tween.tween_property(self, "limit_left", new_limit_right - HORI_SCREEN_SIZE, TRANSITION_TIME)
		tween.tween_property(self, "limit_right", new_limit_right, TRANSITION_TIME)
	elif transition_dir == Global.TransitionDir.up:
		limit_bottom = limit_top + VERT_SCREEN_SIZE
		limit_left = new_limit_left
		limit_right = new_limit_right
		var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
		tween.finished.connect(_on_transition_finished.bind(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right))
		tween.tween_property(self, "limit_top", new_limit_bottom - VERT_SCREEN_SIZE, TRANSITION_TIME)
		tween.tween_property(self, "limit_bottom", new_limit_bottom, TRANSITION_TIME)
	elif transition_dir == Global.TransitionDir.down:
		limit_top = limit_bottom - VERT_SCREEN_SIZE
		limit_left = new_limit_left
		limit_right = new_limit_right
		var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
		tween.finished.connect(_on_transition_finished.bind(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right))
		tween.tween_property(self, "limit_top", new_limit_top, TRANSITION_TIME)
		tween.tween_property(self, "limit_bottom", new_limit_top + VERT_SCREEN_SIZE, TRANSITION_TIME)
	

func gate_transition(new_limit_top: int, new_limit_left: int, new_limit_bottom: int, new_limit_right: int):
	limit_left = limit_right - HORI_SCREEN_SIZE
	limit_top = new_limit_top
	limit_bottom = new_limit_bottom
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
	tween.finished.connect(_on_gate_transition_finished.bind(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right))
	tween.tween_property(self, "limit_left", new_limit_left, GATE_TRANSITION_TIME)
	tween.tween_property(self, "limit_right", new_limit_left + HORI_SCREEN_SIZE, GATE_TRANSITION_TIME)

func _on_transition_finished(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right):
	limit_top = new_limit_top
	limit_left = new_limit_left
	limit_bottom = new_limit_bottom
	limit_right = new_limit_right
	emit_signal("transition_finished")

func _on_gate_transition_finished(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right):
	limit_top = new_limit_top
	limit_left = new_limit_left
	limit_bottom = new_limit_bottom
	limit_right = new_limit_right
	emit_signal("gate_transition_finished")
