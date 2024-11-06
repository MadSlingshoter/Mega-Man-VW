extends CharacterBody2D


@export var SPEED = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations = $Animations
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var ray_cast = $RayCast2D

func _ready():
	animations.play("drive")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = -SPEED
	
	if ray_cast.is_colliding():
		enemy_death.death()
		queue_free()
	
	move_and_slide()


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
