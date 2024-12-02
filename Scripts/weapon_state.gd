class_name WeaponState
extends Node

@export var weapon : Resource
var projectile
const MAX_ENERGY : int = 28
var curr_energy: int = 28
var parent: Player
var controller: ShootingController
# color things

func shoot() -> bool:
	return false

func add_energy(value: int):
	var prev_energy = curr_energy
	curr_energy = clamp(curr_energy + value, 0, MAX_ENERGY)
	if curr_energy != prev_energy:
		AudioManager.play_recover_sound()
