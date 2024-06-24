class_name ShootingController
extends Node

signal energy_updated(new_energy: int)
#signal weapon_changed(new_energy: int, colors)

var curr_weapon_state: WeaponState
@export var mega_buster: WeaponState
@export var bowser_fire: WeaponState


func init(parent: Player):
	for child in get_children():
		child.parent = parent
		child.controller = self
	
	curr_weapon_state = mega_buster

func shoot() -> bool:
	return curr_weapon_state.shoot()

func switch_weapons(new_weapon: Global.Weapon):
	match new_weapon:
		Global.Weapon.mega_buster:
			curr_weapon_state = mega_buster
		Global.Weapon.bowser_fire:
			curr_weapon_state = bowser_fire
	# update color and weapon energy bar
	
	# emit_signal("weapon_changed", things)
