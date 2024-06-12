extends Room

@export var boss_spawner: BossSpawner

func when_entered():
	boss_spawner.spawn_boss()
