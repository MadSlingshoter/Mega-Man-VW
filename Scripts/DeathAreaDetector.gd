extends Area2D
class_name DeathAreaDetector

@export var health : Health

func insta_kill() -> bool:
	return health.pierce_damage(99)

func spike_kill() -> bool:
	return health.damage(99)
