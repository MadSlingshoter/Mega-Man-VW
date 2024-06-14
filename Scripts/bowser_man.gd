extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var hop_count = 0
var jump_transition_chance = -0.6

@onready var state_machine = $BossStateManager
@onready var animations = $Animations
@onready var effects_animation = $Animations/EffectsAnimationPlayer
@onready var health = $Health
@onready var health_bar = $BarCanvasLayer/BossHealthBar
@onready var collision_box = $CollisionShape2D
@onready var hurt_box = $Hurtbox/CollisionShape2D
@onready var contact_box = $ContactBox/CollisionShape2D
@onready var fire_point = $FirePoint

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.init(self, animations)
	turn_around()
	collision_box.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.process_physics(delta)

func turn_around() -> void:
	direction *= -1
	scale.x = -scale.x

func face_player():
	if (Global.player.global_position.x > global_position.x and direction < 0) or (Global.player.global_position.x < global_position.x and direction > 0):
		turn_around()

func _on_health_health_damaged(curr_health):
	effects_animation.play("flash")
	health_bar.value = curr_health

func _on_health_invul_over():
	effects_animation.play("rest")


func _on_health_killed():
	effects_animation.stop(false)
	effects_animation.process_mode = Node.PROCESS_MODE_DISABLED
	collision_box.set_deferred("disabled", true)
	hurt_box.set_deferred("disabled", true)
	contact_box.set_deferred("disabled", true)
	state_machine.death()
	Global.beaten_bowserman = true

func _on_boss_intro_pose_finished():
	health_bar.show()
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.finished.connect(_on_health_fill_finished)
	tween.tween_property(health_bar, "value", health.MAX_HEALTH, 4.0)

func _on_health_fill_finished():
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_INHERIT
	Global.can_pause = true
	state_machine.start()


func _on_boss_intro_add_collision():
	collision_box.set_deferred("disabled", false)


