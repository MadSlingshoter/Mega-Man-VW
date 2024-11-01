extends Node2D

@export var music_path: String

@onready var cp0 = $Checkpoint0
@onready var cp1 = $Checkpoint1
@onready var cp2 = $Checkpoint2
@onready var player = preload("res://Characters/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level_name = Global.Level.cat_man
	var p = player.instantiate()
	add_child(p)
	if Global.checkpoint_num == 0:
		p.global_position = cp0.global_position
	elif Global.checkpoint_num == 1:
		p.global_position = cp1.global_position
	elif Global.checkpoint_num == 2:
		p.global_position = cp2.global_position




func _on_pits_area_entered(area):
	if area is DeathAreaDetector:
		area.insta_kill()
