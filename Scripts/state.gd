class_name State
extends Node

@export var move_speed: float = 100
@export var animation_name : String

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: CharacterBody2D
var animations: AnimatedSprite2D

func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		child.parent = parent

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null


