extends Node

enum TransitionDir {up, down, left, right}
enum Weapon {mega_buster, bowser_fire, car_wheel, constuction_bomb, waffle_missile, police_shock, lego_shield, cat_scratch, gold_tornado, enemy, hazard}
enum Level {start_menu, stage_select, continue_menu, bowser_man, car_man, construction_man, waffle_man, police_man, lego_man, cat_man, gold_man, test2, test_boss}
enum Pickup {random_drop, small_health, big_health, small_energy, big_energy, extra_life} # to add: tanks

var curr_scene = null

const MAX_LIVES = 9

var checkpoint_num : int = 0
var level_name : Level
var can_pause : bool = false
var player : Player
var selected_weapon: Weapon

var num_of_lives : int = 2:
	set(value):
		num_of_lives = clamp(value, 0 , MAX_LIVES)

# Checks for beaten stages, used for stage selection and available weapons
var beaten_bowserman : bool = true
var beaten_waffleman : bool = false
var beaten_carman : bool = false
var beaten_legoman : bool = false
var beaten_catman : bool = true
var beaten_constructionman : bool = false
var beaten_goldman : bool = false
var beaten_policeman : bool = false
var beaten_wily1 : bool = false
var beaten_wily2 : bool = false
var beaten_wily3 : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count() - 1)
	randomize()


func goto_scene(scene_name : Level):
	var path
	match scene_name:
		Level.start_menu:
			path = "res://Menus/start_menu.tscn"
		Level.stage_select:
			path = "res://Menus/stage_select_menu.tscn"
		Level.continue_menu:
			path = "res://Menus/continue_menu.tscn"
		Level.bowser_man:
			path = "res://Levels/bowser_man_stage.tscn"
		Level.car_man:
			path = "res://Levels/car_man_stage.tscn"
		Level.cat_man:
			path = "res://Levels/cat_man_stage.tscn"
		Level.test2:
			path = "res://Levels/test_level_2.tscn"
		Level.test_boss:
			path = "res://Levels/test_level_boss.tscn"
	
	
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	curr_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	curr_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(curr_scene)

func restart_level():
	#call_deferred("_deferred_restart_scene")
	#get_tree().reload_current_scene()
	goto_scene(level_name) # work around because reload_current_scene does not work becase Parameter "current_scene" is null somehow

#func _deferred_restart_scene():
#	curr_scene.get_tree().reload_current_scene()

func clear_screen():
	for shot in get_tree().get_nodes_in_group("shots"):
		shot.queue_free()
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()
	for shot in get_tree().get_nodes_in_group("enemy_shots"):
		shot.queue_free()
