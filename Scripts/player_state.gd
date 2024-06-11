class_name PlayerState
extends Node

@export var move_speed: float = 82.5
@export var can_shoot: bool
var can_change_to_hurt: bool = true
@export var animation_name: String

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: Player

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent

func enter() -> void:
	if !can_shoot and !parent.shooting_timer.is_stopped():
		parent.shooting_timer.stop()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> PlayerState:
	return null

func process_frame(delta: float) -> PlayerState:
	return null

func process_physics(delta: float) -> PlayerState:
	return null


