class_name Player
extends CharacterBody2D

signal health_changed(new_health)
signal energy_bar_color_changed(new_color1: Color, new_color2: Color)

const MAX_SHOTS = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_damaged : bool = false
var is_uncontrollable : bool = false
var first_room : bool = true
var is_transitioning : bool = false
var is_gate_transitioning : bool = false
var transition_dir : Global.TransitionDir
var saved_velocity_y : float
var curr_room: Room

@export var MAX_FALL_SPEED : float
@export var TRANSITION_SPEED : float
@export var TRANSITION_GATE_SPEED : float

@onready var state_machine = $PlayerStateManager
@onready var shooting_timer = $ShootingTimer
@onready var gate_timer = $GateTimer
@onready var health = $Health
@onready var animations = $Animations
@onready var effects_animation = $Animations/EffectsAnimationPlayer
@onready var collision_box = $CollisionBox
@onready var collision_box_slide = $CollisionBoxSlide
@onready var hurtbox = $Hurtbox/HurtBoxCollision
@onready var hurtbox_slide = $Hurtbox/HurtBoxCollisionSlide
@onready var room_detect_box = $RoomDetector/DetectorBox
@onready var room_detect_box_slide = $RoomDetector/DetectorBoxSlide
@onready var pickup_detect_box = $PickupDetector/PickupBox
@onready var pickup_detect_box_slide = $PickupDetector/PickupBoxSlide
@onready var shape_cast_slide = $ShapeCastSlide
@onready var cam = $CameraCustom
@onready var shooting_controller = $ShootingController
@onready var shot_point = $ShotPoint

func _ready():
	#teleport in animation
	Global.can_pause = true
	state_machine.init(self)
	shooting_controller.init(self)
	switch_color()
	Global.player = self

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta):
	if is_gate_transitioning and gate_timer.is_stopped():
		velocity.x = TRANSITION_GATE_SPEED
		move_and_slide()
	elif is_transitioning and gate_timer.is_stopped():
		if transition_dir == Global.TransitionDir.right:
			velocity.x = TRANSITION_SPEED
		if transition_dir == Global.TransitionDir.left:
			velocity.x = -TRANSITION_SPEED
		if transition_dir == Global.TransitionDir.down:
			velocity.y = TRANSITION_SPEED
		if transition_dir == Global.TransitionDir.up:
			velocity.y = -TRANSITION_SPEED
		move_and_slide()
	elif gate_timer.is_stopped():
		state_machine.process_physics(delta)
		
		if Input.is_action_just_pressed("shoot"):
			shoot()
		
		update_animation()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func update_animation():
	var animation_name = state_machine.current_state.animation_name
	if !shooting_timer.is_stopped():
		animation_name += "_shoot"
	animations.play(animation_name)
	

func update_facing_direction(direction: int):
	if direction > 0:
		animations.flip_h = false
		$ShotPoint.position.x = 16
		animations.offset.x = 3
	elif direction < 0:
		animations.flip_h = true
		$ShotPoint.position.x = -16
		animations.offset.x = -3

func shoot():
	if state_machine.current_state.can_shoot:
		# Checks the number of shots on the screen before firing a new one
		if shooting_controller.shoot():
			shooting_timer.start()

func switch_color():
	var new_color1
	var new_color2
	match shooting_controller.curr_weapon:
		Global.Weapon.mega_buster:
			new_color1 = Color(0.0, 0.45, 0.97)
			new_color2 = Color(0.0, 1.0, 1.0)
			
		Global.Weapon.bowser_fire:
			new_color1 = Color(0.0, 0.51, 0.0)
			new_color2 = Color(0.85, 0.6, 0.17)
	
	animations.material.set("shader_param/new_color1", new_color1)
	animations.material.set("shader_param/new_color2", new_color2)
	emit_signal("energy_bar_color_changed", new_color1, new_color2)

func _on_health_health_damaged(new_health):
	effects_animation.play("flash")
	state_machine.player_hurt()
	emit_signal("health_changed",new_health)

func _on_health_killed():
	effects_animation.stop(false)
	effects_animation.process_mode = Node.PROCESS_MODE_DISABLED
	state_machine.player_death()

func _on_health_invul_over():
	effects_animation.play("rest")

func _on_pickup_detector_area_entered(area):
	if area is PickupBox:
		if area.parent.type == Global.Pickup.small_health or area.parent.type == Global.Pickup.big_health:
			health.heal(area.parent.value)
		elif area.parent.type == Global.Pickup.small_energy or area.parent.type == Global.Pickup.big_energy:
			shooting_controller.add_energy(area.parent.value)
		elif area.parent.type == Global.Pickup.extra_life:
			Global.num_of_lives += 1
		area.parent.queue_free()

func _on_health_health_healed(new_health):
	emit_signal("health_changed",new_health)

# camera things for transitioning to new screen
func _on_room_detector_area_entered(area):
	if area is Room and not is_transitioning:
		if is_gate_transitioning:
			is_gate_transitioning = false
		else:
			if not area == curr_room:
				room_transition(area)
	elif area.get_parent() is BossGate and not is_transitioning and not is_gate_transitioning:
		gate_transition(area.get_parent())

func room_transition(room: Room):
	var collision_shape = room.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var new_limit_top = collision_shape.global_position.y - size.y/2
	var new_limit_left = collision_shape.global_position.x - size.x/2
	var new_limit_bottom = new_limit_top + size.y
	var new_limit_right = new_limit_left + size.x
	
	if first_room:
		cam.spawn_limits(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right)
		first_room = false
		curr_room = room
		curr_room.when_entered()
	else:
		#check transition direction
		if new_limit_left >= cam.limit_right:
			transition_dir = Global.TransitionDir.right
		elif new_limit_right <= cam.limit_left:
			transition_dir = Global.TransitionDir.left
		elif new_limit_bottom <= cam.limit_top:
			#should also check if player is climbing
			transition_dir = Global.TransitionDir.up
		elif new_limit_top >= cam.limit_bottom:
			transition_dir = Global.TransitionDir.down
		
		curr_room.when_exited()
		is_transitioning = true
		Global.can_pause = false
		health.can_interact = false
		process_mode = Node.PROCESS_MODE_ALWAYS
		saved_velocity_y = velocity.y
		velocity.x = 0
		velocity.y = 0
		curr_room = room
		
		cam.screen_transition(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right, transition_dir)
		Global.clear_screen()
		get_tree().paused = true

func gate_transition(boss_gate: BossGate):
	boss_gate.open()
	gate_timer.start()
	gate_timer.timeout.connect(_on_gate_opened.bind(boss_gate))

func _on_gate_opened(boss_gate: BossGate):
	gate_timer.timeout.disconnect(_on_gate_opened)
	var new_room = boss_gate.get_parent()
	var collision_shape = new_room.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var new_limit_top = collision_shape.global_position.y - size.y/2
	var new_limit_left = collision_shape.global_position.x - size.x/2
	var new_limit_bottom = new_limit_top + size.y
	var new_limit_right = new_limit_left + size.x
	
	# transition_dir = Global.TransitionDir.right # will always be to the right for consistency. Might add down later
	curr_room.when_exited()
	is_transitioning = true
	is_gate_transitioning = true
	Global.can_pause = false
	health.can_interact = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	saved_velocity_y = velocity.y
	velocity.x = 0
	velocity.y = 0
	curr_room = new_room
	
	cam.gate_transition(new_limit_top, new_limit_left, new_limit_bottom, new_limit_right)
	get_tree().paused = true

func _on_camera_custom_transition_finished():
	get_tree().paused = false
	is_transitioning = false
	Global.can_pause = true
	health.can_interact = true
	process_mode = Node.PROCESS_MODE_INHERIT
	velocity.y = saved_velocity_y
	curr_room.when_entered()

func _on_camera_custom_gate_transition_finished():
	curr_room.boss_gate.close()
	gate_timer.start()
	gate_timer.timeout.connect(_on_gate_closed)

func _on_gate_closed():
	gate_timer.timeout.disconnect(_on_gate_closed)
	get_tree().paused = false
	is_transitioning = false
	Global.can_pause = true
	health.can_interact = true
	process_mode = Node.PROCESS_MODE_INHERIT
	velocity.y = saved_velocity_y
	curr_room.when_entered()





