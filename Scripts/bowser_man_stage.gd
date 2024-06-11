extends Node2D

@onready var cp0 = $Checkpoint0
@onready var cp1 = $Checkpoint1
@onready var cp2 = $Checkpoint2
@onready var player = preload("res://Characters/player.tscn")
var p
var attack : Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level_name = Global.Level.bowser_man
	p = player.instantiate()
	add_child(p)
	if Global.checkpoint_num == 0:
		p.global_position = cp0.global_position
	elif Global.checkpoint_num == 1:
		p.global_position = cp1.global_position
	elif Global.checkpoint_num == 2:
		p.global_position = cp2.global_position

func _on_pits_area_entered(area):
	if area is Hurtbox and area.get_parent() is Player:
		attack = Attack.new()
		attack.damage = 28
		attack.attack_type = Global.Weapon.hazard
		area.pierce_damage(attack)
