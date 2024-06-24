extends WeaponState

const MAX_SHOTS = 3

func _ready():
	curr_energy = -1

func shoot() -> bool:
	if get_tree().get_nodes_in_group("shots").size() < MAX_SHOTS:
		projectile = weapon.instantiate()
		projectile.init(parent.animations.flip_h)
		parent.get_parent().add_child(projectile)
		projectile.global_position = parent.shot_point.global_position
		projectile.add_to_group("shots")
		return true
	return false
