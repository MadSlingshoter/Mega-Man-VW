extends Node2D

@onready var cp0 = $Checkpoint0
@onready var player = preload("res://Characters/player.tscn")
var p

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level_name = Global.Level.test_boss
	p = player.instantiate()
	add_child(p)
	if Global.checkpoint_num == 0:
		p.global_position = cp0.global_position

