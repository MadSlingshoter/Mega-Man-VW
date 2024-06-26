class_name Weapon
extends Area2D

@export var DAMAGE: int
@export var ATTACK_TYPE: Global.Weapon
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D

var attack: Attack
var is_relected : bool = false
var direction = 1

func _ready():
	attack = Attack.new()
	attack.damage = DAMAGE
	attack.attack_type = ATTACK_TYPE

func init(flip: bool):
	if flip:
		scale.x = -scale.x
		direction = -1
	
