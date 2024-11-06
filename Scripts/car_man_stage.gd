extends Node2D

@export var music_path: String

@onready var cp0 = $Checkpoint0
@onready var cp1 = $Checkpoint1
@onready var cp2 = $Checkpoint2
@onready var player = preload("res://Characters/player.tscn")

var player_spike_contact: bool = false
var player_death_area_detector: DeathAreaDetector

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level_name = Global.Level.car_man
	var p = player.instantiate()
	add_child(p)
	if Global.checkpoint_num == 0:
		p.global_position = cp0.global_position
	elif Global.checkpoint_num == 1:
		p.global_position = cp1.global_position
	elif Global.checkpoint_num == 2:
		p.global_position = cp2.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Needed because otherwise would be able to walk on spikes after i-frames are over
	if player_spike_contact:
		player_death_area_detector.spike_kill()

func _on_pits_area_entered(area):
	if area is DeathAreaDetector:
		area.insta_kill()

func _on_spikes_area_entered(area):
	if area is DeathAreaDetector:
		player_death_area_detector = area

func _on_spikes_area_exited(area):
	if area is DeathAreaDetector:
		player_death_area_detector = null
