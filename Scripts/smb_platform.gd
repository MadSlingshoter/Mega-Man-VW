class_name SMBPlatform
extends Node2D


@onready var platform = $Platform

var direction : int = 1
var duration : float = 5.0
const TRAVEL_LENGTH  = Vector2(0, 260)

func init(move_direction: int):
	direction = move_direction

func start_move():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.finished.connect(_on_path_finished)
	tween.tween_property(platform, "position", TRAVEL_LENGTH*direction, duration)

func _on_path_finished():
	queue_free()
