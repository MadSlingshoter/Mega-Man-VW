extends CharacterBody2D


@export var SPEED: float
var direction = 1


@onready var animations_top = $AnimationsTop
@onready var animations_bottom = $AnimationsBottom
@onready var health = $Health
@onready var enemy_death = $EnemyDeathComponent
@onready var item_drop = $ItemDropComponent

func _ready():
	if Global.player.global_position.x < global_position.x:
		turn_around()

func _physics_process(delta):
	velocity.x = SPEED * direction
	
	
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x = -scale.x
