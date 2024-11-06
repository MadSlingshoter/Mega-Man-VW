extends CharacterBody2D


@export var SPEED: float
@export var enemy_shot : Resource

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

enum State {hiding, emerging, moving}
var state = State.hiding

@onready var animations = $Animations
@onready var health = $Health
@onready var contact_box = $ContactBox
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var player_detector = $PlayerDetector
@onready var shoot_timer = $ShootTimer
@onready var post_shoot_timer = $PostShootTimer
@onready var walk_timer = $WalkTimer
@onready var wait_timer = $WaitTimer
@onready var hurtbox = $Hurtbox/CollisionShape2D
@onready var shieldbox = $ShieldBox/CollisionShape2D
@onready var contactbox_hiding = $ContactBox/ContactShapeHiding
@onready var contactbox_emerged = $ContactBox/ContactShapeEmerged
@onready var shot_point = $ShotPoint

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == State.hiding:
		animations.play("hiding")
		if player_detector.player_in_area and wait_timer.is_stopped():
			emerge()
	if state == State.moving:
		animations.play("walk")
		velocity.x = direction * SPEED
	
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func emerge():
	if (direction > 0 and Global.player.global_position.x < global_position.x) or (direction < 0 and Global.player.global_position.x > global_position.x):
		turn_around()
	shoot_timer.start()
	state = State.emerging
	animations.play("emerge")
	hurtbox.set_deferred("disabled", false)
	shieldbox.set_deferred("disabled", true)
	contactbox_emerged.set_deferred("disabled", false)
	contactbox_hiding.set_deferred("disabled", true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


func _on_shoot_timer_timeout():
	post_shoot_timer.start()
	var s1
	s1 = enemy_shot.instantiate()
	s1.init(direction)
	get_parent().add_child(s1)
	s1.global_position = shot_point.global_position
	s1.add_to_group("enemy_shots")
	var s2
	s2 = enemy_shot.instantiate()
	s2.init(direction)
	s2.vertical_direction = 1
	get_parent().add_child(s2)
	s2.global_position = shot_point.global_position
	s2.add_to_group("enemy_shots")
	var s3
	s3 = enemy_shot.instantiate()
	s3.init(direction)
	s3.vertical_direction = -1
	get_parent().add_child(s3)
	s3.global_position = shot_point.global_position
	s3.add_to_group("enemy_shots")
	AudioManager.play_enemy_shoot_sound()


func _on_post_shoot_timer_timeout():
	walk_timer.start()
	state = State.moving


func _on_walk_timer_timeout():
	wait_timer.start()
	state = State.hiding
	if (direction > 0 and Global.player.global_position.x < global_position.x) or (direction < 0 and Global.player.global_position.x > global_position.x):
		turn_around()
	velocity.x = 0
	hurtbox.set_deferred("disabled", true)
	shieldbox.set_deferred("disabled", false)
	contactbox_emerged.set_deferred("disabled", true)
	contactbox_hiding.set_deferred("disabled", false)
