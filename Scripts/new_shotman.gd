extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
@export var shot_velocity_y : float
@export var acceleration_y : float

enum State {idle, shoot}
var state = State.idle
var distance_to_player: Vector2

@onready var lobbed_shot = preload("res://Weapons/EnemyWeapons/lobbed_shot.tscn")

@onready var animations = $Animations
@onready var health = $Health
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var shot_point = $ShotPoint
@onready var shot_wait_timer = $ShotWaitTimer

func _ready():
	shot_wait_timer.start()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == State.idle:
		animations.play("idle")
		distance_to_player = Vector2(abs(Global.player.global_position.x - global_position.x), Global.player.global_position.y - global_position.y)
		if shot_wait_timer.is_stopped() and distance_to_player.x < 600 and (distance_to_player.y > -150 and distance_to_player.y < 400):
			shot_wait_timer.start(1.2)
			state = State.shoot
			animations.play("shoot")
			animations.animation_finished.connect(_on_shoot_anim_finished)
			
			if distance_to_player.y < -30:
				distance_to_player.x += 50
			elif distance_to_player.y > 50:
				distance_to_player.x -= 50
			distance_to_player.x = clamp(distance_to_player.x, 30, 600)
			
			if (Global.player.global_position.x - global_position.x) < 1:
				direction = -1
			else:
				direction = 1
			
			var s
			s = lobbed_shot.instantiate()
			s.init(direction)
			var shot_time = -2 * shot_velocity_y / acceleration_y # time to hit player at equal height
			s.speed = Vector2(distance_to_player.x / shot_time, shot_velocity_y)
			s.acceleration_y = acceleration_y
			get_parent().add_child(s)
			s.global_position = shot_point.global_position
			s.add_to_group("enemy_shots")
			AudioManager.play_enemy_shoot_sound()
	
	move_and_slide()

func _on_shoot_anim_finished():
	animations.animation_finished.disconnect(_on_shoot_anim_finished)
	state = State.idle


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
