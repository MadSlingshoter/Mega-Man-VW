extends CharacterBody2D

@export var SPEED :float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var animations = $Animations
@onready var raycast_side = $RayCastSide
@onready var health = $Health
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_character()
	detect_turn_around()
	animations.play("walk")
	
	move_and_slide()

func move_character():
	velocity.x = SPEED * direction

func detect_turn_around():
	if raycast_side.is_colliding():
		turn_around()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
