extends CharacterBody2D


@export var SPEED: float
@export var bomb : Resource
var direction = 1

enum State {standby, dropping}
var state = State.standby

@onready var animations_top = $AnimationsTop
@onready var animations_bottom = $AnimationsBottom
@onready var health = $Health
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent
@onready var drop_point = $DropPoint
@onready var player_detector = $PlayerDetector

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()
	animations_top.play("fly")
	animations_bottom.play("hold3")

func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if state == State.standby:
		if player_detector.player_in_area:
			state = State.dropping
			animations_bottom.play("drop3")
			animations_bottom.animation_finished.connect(_on_drop3_anim_finished)
	
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x = -scale.x

func drop_bomb():
	var b = bomb.instantiate()
	b.init(direction)
	get_parent().add_child(b)
	b.global_position = drop_point.global_position
	b.add_to_group("enemy_shots")

func _on_drop3_anim_finished():
	animations_bottom.animation_finished.disconnect(_on_drop3_anim_finished)
	drop_bomb()
	animations_bottom.play("drop2")
	animations_bottom.animation_finished.connect(_on_drop2_anim_finished)

func _on_drop2_anim_finished():
	animations_bottom.animation_finished.disconnect(_on_drop2_anim_finished)
	drop_bomb()
	animations_bottom.play("drop1")
	animations_bottom.animation_finished.connect(_on_drop1_anim_finished)

func _on_drop1_anim_finished():
	animations_bottom.animation_finished.disconnect(_on_drop1_anim_finished)
	drop_bomb()
	animations_bottom.play("hold0")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_health_killed():
	item_drop.drop_pickup()
	enemy_death.death()
	queue_free()
