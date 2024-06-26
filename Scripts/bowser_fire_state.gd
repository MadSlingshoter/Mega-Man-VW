extends WeaponState

const MAX_SHOTS = 2
const ENERGY_COST = 2

func shoot() -> bool:
	if get_tree().get_nodes_in_group("shots").size() < MAX_SHOTS and curr_energy > 0:
		projectile = weapon.instantiate()
		projectile.init(parent.animations.flip_h)
		parent.get_parent().add_child(projectile)
		projectile.global_position = parent.shot_point.global_position
		projectile.add_to_group("shots")
		curr_energy = clamp(curr_energy - ENERGY_COST, 0, MAX_ENERGY)
		return true
	return false
