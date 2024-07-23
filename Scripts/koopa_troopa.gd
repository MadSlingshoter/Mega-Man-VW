extends CharacterBody2D

@export var SPEED : float
@export var MAX_HIDE_TIME : float
@export var MAX_EMERGING_TIME : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

enum State {walk, hide, emerging}
var state = State.walk
var time : float = -2.0

@onready var animations = $Animations
@onready var raycast_side = $RayCastSide
@onready var raycast_down = $RayCastDown
@onready var health = $Health
@onready var hurt_collision_walk = $Hurtbox/CollisionShapeWalk
@onready var contact_collision_walk = $ContactBox/CollisionShapeWalk
@onready var contact_collision_hide = $ContactBox/CollisionShapeHide
@onready var shield_collision_hide = $ShieldBox/CollisionShapeHide
@onready var enemy_death = $EnemyDeathComponent

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == State.walk:
		move_character()
#		detect_turn_around()
		# for some reason, need two delta wait time before checking for ground?
		if time < -1.0:
			time = -1.0
		elif time < 0.0:
			time = 0.0
		else:
			detect_turn_around()
		animations.play("walk")
	
	elif state == State.hide:
		time += delta
		animations.play("hide")
		if time > MAX_HIDE_TIME:
			time = 0.0
			state = State.emerging
	
	elif state == State.emerging:
		time += delta
		animations.play("emerging")
		if time > MAX_EMERGING_TIME:
			time = 0.0
			state = State.walk
			hurt_collision_walk.set_deferred("disabled", false)
			contact_collision_walk.set_deferred("disabled", false)
			contact_collision_hide.set_deferred("disabled", true)
			shield_collision_hide.set_deferred("disabled", true)
	
	move_and_slide()

func move_character():
	velocity.x = SPEED * direction

func detect_turn_around():
	if raycast_side.is_colliding() or (!raycast_down.is_colliding() and is_on_floor()):
		turn_around()

func turn_around():
	direction *= -1
	scale.x = -scale.x


func _on_health_health_damaged(_health):
	velocity.x = 0.0
	state = State.hide
	hurt_collision_walk.set_deferred("disabled", true)
	contact_collision_walk.set_deferred("disabled", true)
	contact_collision_hide.set_deferred("disabled", false)
	shield_collision_hide.set_deferred("disabled", false)

func _on_health_killed():
	enemy_death.death()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



