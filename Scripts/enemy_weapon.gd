class_name EnemyWeapon
extends Area2D

@export var DAMAGE: int
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D

var attack: Attack
var direction = 1
var is_contacting: bool = false
var playerHurtBox: Hurtbox

func _ready():
	attack = Attack.new()
	attack.damage = DAMAGE
	attack.attack_type = Global.Weapon.enemy

func init(source_direction: int):
	if source_direction < 0:
		scale.x = -scale.x
		direction = -1

