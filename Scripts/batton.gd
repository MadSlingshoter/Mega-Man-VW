extends CharacterBody2D


@export var SPEED :float

enum State {idle, start_fly, fly, after_hit}
var state = State.idle

@onready var animations = $Animations
@onready var health = $Health
@onready var contact_box = $ContactBox
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var after_hit_timer = $AfterHitTimer

func _ready():
	animations.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.fly:
		var player_pos = Global.player.global_position
		var direction = (player_pos - global_position).normalized()
		velocity = direction * SPEED
		if contact_box.is_contacting:
			state = State.after_hit
			after_hit_timer.start()
	elif state == State.after_hit:
		velocity = Vector2(0, -1) * (SPEED + 5)
	
	move_and_slide()

func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func start_flying():
	if state == State.idle:
		state = State.start_fly
		animations.play("start_fly")
		animations.animation_finished.connect(_on_start_fly_finished)

func _on_player_detector_player_detected():
	start_flying()

func _on_health_health_damaged(curr_health):
	start_flying()

func _on_start_fly_finished():
	animations.animation_finished.disconnect(_on_start_fly_finished)
	state = State.fly
	animations.play("fly")


func _on_after_hit_timer_timeout():
	state = State.fly




