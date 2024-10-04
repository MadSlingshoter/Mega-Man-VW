extends CharacterBody2D


@export var SPEED: float
@export var JUMP_FORCE: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

enum State {idle, jump, fall, land}
var state = State.idle

@onready var animations = $Animations
@onready var health = $Health
@onready var contact_box = $ContactBox
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var player_detector = $PlayerDetector
@onready var hurtbox_collision_idle = $Hurtbox/IdleCollision
@onready var hurtbox_collision_jump = $Hurtbox/JumpCollision
@onready var contact_box_collision_idle = $ContactBox/IdleCollision
@onready var contact_box_collision_jump = $ContactBox/JumpCollision

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == State.idle:
		animations.play("idle")
		if player_detector.player_in_area:
			jump()
	elif state == State.jump:
		animations.play("jump")
		velocity.x = SPEED * direction
		if velocity.y > 0:
			state = State.fall
	elif state == State.fall:
		if is_on_floor():
			state = State.land
			velocity.x = 0
			animations.play("land")
			animations.animation_finished.connect(_on_land_finished)
	
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func jump():
	state = State.jump
	hurtbox_collision_idle.set_deferred("disabled", true)
	hurtbox_collision_jump.set_deferred("disabled", false)
	contact_box_collision_idle.set_deferred("disabled", true)
	contact_box_collision_jump.set_deferred("disabled", false)
	if (direction > 0 and Global.player.global_position.x < global_position.x) or (direction < 0 and Global.player.global_position.x > global_position.x):
		turn_around()
	velocity.y = JUMP_FORCE

func _on_land_finished():
	animations.animation_finished.disconnect(_on_land_finished)
	hurtbox_collision_idle.set_deferred("disabled", false)
	hurtbox_collision_jump.set_deferred("disabled", true)
	contact_box_collision_idle.set_deferred("disabled", false)
	contact_box_collision_jump.set_deferred("disabled", true)
	state = State.idle

func _on_health_health_damaged(curr_health):
	if state == State.idle and not player_detector.player_in_area:
		jump()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()



