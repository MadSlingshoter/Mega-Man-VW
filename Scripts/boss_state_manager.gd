extends Node

@export var idle_state: State
@export var intro_state: State
@export var starting_state: State
@export var death_state: State
var current_state: State

func init(parent: CharacterBody2D, animations: AnimatedSprite2D) -> void:
	for child in get_children():
		child.parent = parent
		child.animations = animations
	
	change_state(idle_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func intro() -> void:
	change_state(intro_state)

func start() -> void:
	change_state(starting_state)

func death() -> void:
	change_state(death_state)

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)






