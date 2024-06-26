extends Node

enum TransitionDir {up, down, left, right}
enum Weapon {mega_buster, bowser_fire, weapon2, weapon3, weapon4, weapon5, weapon6, weapon7, weapon8, enemy, hazard}
enum Level {start_menu, stage_select, continue_menu, bowser_man, test1, test2, test_boss}

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
var beaten_catman : bool = false
var beaten_constructionman : bool = false
var beaten_shadowsoraman : bool = false
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
		Level.test1:
			path = "res://Levels/test_level.tscn"
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
