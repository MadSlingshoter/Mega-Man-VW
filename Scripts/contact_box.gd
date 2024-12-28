extends Area2D
## Area2D for enemies that causes the player to take damage on contact.

## The amount of damage the player takes on contact
@export var CONTACT_DAMAGE : int = 3

## Attack object
var attack: Attack
## The Hurtbox node of the player
var playerHurtBox: Hurtbox
## If the player is currently touching the ContactBox
var is_contacting: bool = false

func _ready():
	# Setting up the attack
	attack = Attack.new()
	attack.damage = CONTACT_DAMAGE
	attack.attack_type = Global.Weapon.ENEMY

func _physics_process(delta):
	# Try to apply damage to the player when they are in contact.
	if is_contacting and playerHurtBox != null:
		playerHurtBox.damage(attack)

## Adds the player's hurtbox if they enter the area
func _on_area_entered(area):
	if area is Hurtbox:
		playerHurtBox = area
		is_contacting = true

## Removes the player's hurtbox if they exit the area
func _on_area_exited(area):
	if area is Hurtbox:
		playerHurtBox = null
		is_contacting = false
