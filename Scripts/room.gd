class_name Room
extends Area2D

@export var enter_walls: StaticBody2D # walls that activate when entering
@export var exit_walls: StaticBody2D # walls that deactivate when exiting
@export var boss_gate: StaticBody2D
@export var boss_spawner: BossSpawner
@export var checkpoint_number: int = -1

# Called by the player when the player has transitioned into the room
func when_entered():
	if enter_walls:
		enter_walls.process_mode = Node.PROCESS_MODE_INHERIT
	if checkpoint_number > -1:
		Global.checkpoint_num = checkpoint_number
	if boss_spawner:
		boss_spawner.spawn_boss()

# Called by the player when the player is transitioning from the room
func when_exited():
	if exit_walls:
		exit_walls.process_mode = Node.PROCESS_MODE_DISABLED
