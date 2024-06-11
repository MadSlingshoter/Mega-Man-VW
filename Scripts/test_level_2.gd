extends Node2D

@onready var player = preload("res://Characters/player.tscn")
var p
var attack: Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level_name = Global.Level.test2
	p = player.instantiate()
	add_child(p)
	if Global.checkpoint_num == 0:
		p.global_position = $Checkpoint0.global_position
	elif Global.checkpoint_num == 1:
		p.global_position = $Checkpoint1.global_position



func _on_deathplanes_area_entered(area):
	if area is Hurtbox and area.get_parent() is Player:
		attack = Attack.new()
		attack.damage = 28
		attack.attack_type = Global.Weapon.hazard
		area.pierce_damage(attack)



func _on_room_4_area_entered(area):
	Global.checkpoint_num = 1
