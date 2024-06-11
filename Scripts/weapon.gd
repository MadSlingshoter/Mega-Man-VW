class_name Weapon
extends Area2D

@export var SPEED: float
@export var DAMAGE: int
@export var ATTACK_TYPE: Global.Weapon
@export var sprite: Sprite2D
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D

var attack: Attack
var time = 0.0
var is_relected : bool = false

func _ready():
	attack = Attack.new()
	attack.damage = DAMAGE
	attack.attack_type = ATTACK_TYPE

func init(flip):
	sprite.flip_h = flip
	
