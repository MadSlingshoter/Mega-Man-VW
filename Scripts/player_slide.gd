extends PlayerState

@export var idle_state : PlayerState
@export var move_state : PlayerState
@export var jump_state : PlayerState
@export var fall_state : PlayerState
#@export var climb_state : PlayerState

@onready var sliding_timer = $SlidingTimer

func enter() -> void:
	super()
	sliding_timer.start()
	parent.collision_box.set_deferred("disabled", true)
	parent.collision_box_slide.set_deferred("disabled", false)
	parent.hurtbox.set_deferred("disabled", true)
	parent.hurtbox_slide.set_deferred("disabled", false)
	parent.death_area_box.set_deferred("disabled", true)
	parent.death_area_box_slide.set_deferred("disabled", false)
	# can't use this as triggers transition code
#	parent.room_detect_box.set_deferred("disabled", true)
#	parent.room_detect_box_slide.set_deferred("disabled", false)
	parent.pickup_detect_box.set_deferred("disabled", true)
	parent.pickup_detect_box_slide.set_deferred("disabled", false)

func exit() -> void:
	super()
	if !sliding_timer.is_stopped:
		sliding_timer.stop()
	parent.collision_box.set_deferred("disabled", false)
	parent.collision_box_slide.set_deferred("disabled", true)
	parent.hurtbox.set_deferred("disabled", false)
	parent.hurtbox_slide.set_deferred("disabled", true)
	parent.death_area_box.set_deferred("disabled", false)
	parent.death_area_box_slide.set_deferred("disabled", true)
#	parent.room_detect_box.set_deferred("disabled", false)
#	parent.room_detect_box_slide.set_deferred("disabled", true)
	parent.pickup_detect_box.set_deferred("disabled", false)
	parent.pickup_detect_box_slide.set_deferred("disabled", true)


func process_physics(delta: float) -> PlayerState:
	if parent.shape_cast_slide.is_colliding() and can_change_to_hurt:
		can_change_to_hurt = false
	elif !can_change_to_hurt:
		can_change_to_hurt = true
	
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1
	parent.update_facing_direction(direction)
	
	if parent.animations.flip_h == false:
		parent.velocity.x = move_speed
	else:
		parent.velocity.x = -move_speed
	
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	
	# stop when down or jump released or when time runs out, but not when shapecast is detecting ceiling
	if !Input.is_action_pressed("jump") or !Input.is_action_pressed("down") or sliding_timer.is_stopped():
		if !parent.shape_cast_slide.is_colliding():
			if direction != 0:
				return move_state
			return idle_state
	
	return null




