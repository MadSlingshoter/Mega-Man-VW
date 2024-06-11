extends Area2D

@export var CONTACT_DAMAGE : int = 3

var attack: Attack
var playerHurtBox: Hurtbox
var is_contacting: bool = false

func _ready():
	attack = Attack.new()
	attack.damage = CONTACT_DAMAGE
	attack.attack_type = Global.Weapon.enemy

func _physics_process(delta):
	if is_contacting:
		playerHurtBox.damage(attack)

func _on_area_entered(area):
	if area is Hurtbox:
		playerHurtBox = area
		is_contacting = true


func _on_area_exited(area):
	if area is Hurtbox:
		playerHurtBox = null
		is_contacting = false
