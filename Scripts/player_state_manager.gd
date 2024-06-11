extends Node

@export var starting_state: PlayerState
@export var hurt_state: PlayerState
@export var death_state: PlayerState
var current_state: PlayerState

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)

func change_state(new_state: PlayerState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func player_hurt() -> void:
	if current_state.can_change_to_hurt:
		change_state(hurt_state)

func player_death() -> void:
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






