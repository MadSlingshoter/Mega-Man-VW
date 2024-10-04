extends CharacterBody2D


@export var SPEED :float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

enum State {idle, run}
var state = State.idle

var can_turn: bool = false # needed because RayCastDown cannot detect ground when spawning in

@onready var animations = $Animations
@onready var health = $Health
@onready var contact_box = $ContactBox
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var idle_timer = $IdleTimer
@onready var run_timer = $RunTimer
@onready var raycast_side = $RayCastSide
@onready var raycast_down = $RayCastDown

func _ready():
	if Global.player.global_position.x > global_position.x:
		turn_around()
	idle_timer.start()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == State.idle:
		animations.play("idle")
	elif state == State.run:
		animations.play("run")
		velocity.x = SPEED * direction
		if raycast_side.is_colliding() or not raycast_down.is_colliding():
			stop_run()
	
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func stop_run():
	velocity.x = 0
	state = State.idle
	idle_timer.start()

func _on_idle_timer_timeout():
	turn_around()
	state = State.run
	run_timer.start()


func _on_run_timer_timeout():
	stop_run()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


