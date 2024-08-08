class_name ShootingController
extends Node

signal energy_updated(new_energy: int)

var curr_weapon: Global.Weapon
var curr_weapon_state: WeaponState
@export var mega_buster: WeaponState
@export var bowser_fire: WeaponState


func init(parent: Player):
	for child in get_children():
		child.parent = parent
		child.controller = self
	
	curr_weapon = Global.Weapon.mega_buster
	curr_weapon_state = mega_buster

func shoot() -> bool:
	if curr_weapon_state.shoot():
		emit_signal("energy_updated", curr_weapon_state.curr_energy)
		return true
	return false

func switch_weapons(new_weapon: Global.Weapon):
	match new_weapon:
		Global.Weapon.mega_buster:
			curr_weapon = Global.Weapon.mega_buster
			curr_weapon_state = mega_buster
		Global.Weapon.bowser_fire:
			curr_weapon = Global.Weapon.bowser_fire
			curr_weapon_state = bowser_fire
		# rest of weapons
	
	emit_signal("energy_updated", curr_weapon_state.curr_energy)

func get_energies() -> Array[int]:
	var energies: Array[int] = []
	energies.resize(9)
	energies[0] = 28 # mega buster always full because not use
	if Global.beaten_bowserman:
		energies[1] = bowser_fire.curr_energy
	# if statements for rest of bosses
	
	return energies

func add_energy(value: int):
	if curr_weapon != Global.Weapon.mega_buster:
		curr_weapon_state.add_energy(value)
		emit_signal("energy_updated", curr_weapon_state.curr_energy)
