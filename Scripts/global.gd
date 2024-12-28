extends Node

## The direction of the screen transition.
enum TransitionDir {
	## Transition direction up
	UP,
	## Transition direction down
	DOWN,
	## Transition direction left
	LEFT,
	## Transition direction right
	RIGHT,
}

## The weapon types 
enum Weapon {
	## The Mega Buster weapon
	MEGA_BUSTER,
	## The Boswer Fire weapon gotten from Bowser Man
	BOWSER_FIRE,
	## The Car Wheel weapon gotten from Car Man
	CAR_WHEEL,
	## The Construction Bomb weapon gotten from Construction Man
	CONSTRUCTION_BOMB,
	## The Waffle Missle weapon gotten from Waffle Man
	WAFFLE_MISSILE,
	## The Police Shock weapon gotten from Police Man
	POLICE_SHOCK,
	## The Lego Shield weapon gotten from Lego Man
	LEGO_SHIELD,
	## The Cat Scratch weapon gotten from Cat Man
	CAT_SCRATCH,
	## The Gold Tornado weapon gotten from Gold Man
	GOLD_TORNADO,
	## Weapon type for enemies. Not selectable for the player, but for the Attack object.
	ENEMY,
	## Weapon type for stage hazards. Not selectable for the player, but for the Attack object.
	HAZARD,
}

## The scenes in the game
enum Level {
	## The start menu
	START_MENU,
	## The stage select menu
	STAGE_SELECT,
	## The continue menu
	CONTINUE_MENU,
	## The stage for Bowser Man
	BOWSER_MAN,
	## The stage for Car Man
	CAR_MAN,
	## The stage for Construction Man
	CONSTRUCTION_MAN,
	## The stage for Waffle Man
	WAFFLE_MAN,
	## The stage for Police Man
	POLICE_MAN,
	## The stage for Lego Man
	LEGO_MAN,
	## The stage for Cat Man
	CAT_MAN,
	## The stage for Gold Man
	GOLD_MAN,
	## The 1st Wily stage
	WILY1,
	## The 2nd Wily stage
	WILY2,
	## The 3rd Wily stage
	WILY3,
	## The 4th Wily stage
	WILY4,
	## The level for testing things. Not to be used in the final game.
	TEST2,
	## The level for testing bosses. Not to be used in the final game.
	TEST_BOSS,
}

## The types of pickups the player can pick up
enum Pickup {
	## Type for the random pickup that enemies drop
	RANDOM_DROP,
	## Small health pickup
	SMALL_HEALTH,
	## Big health pickup
	BIG_HEALTH,
	## Small energy pickup
	SMALL_ENERGY,
	## Big energy pickup
	BIG_ENERGY,
	## Extra life pickup
	EXTRA_LIFE,
} # to add: tanks

## The maximum number of extra lives the player can hold.
const MAX_LIVES = 9

## The current scene loaded.
var curr_scene = null
## The current checkpoint number in the level.
var checkpoint_num : int = 0
## The current scene.
var level_name : Level
## Flag for if the player can open the pause menu currently.
var can_pause : bool = false
## The player object in the scene for other nodes to easily access it.
var player : Player
## The player's currently selected weapon.
var selected_weapon: Weapon
## The player's current number of extra lives. Defaults to 2 lives. Cannot go below 0 or above
## the maximum number of lives.
var num_of_lives : int = 2:
	set(value):
		num_of_lives = clamp(value, 0 , MAX_LIVES)

# Checks for beaten stages, used for stage selection and available weapons
## Bowser Man has been defeated
var beaten_bowserman : bool = true
## Car Man has been defeated
var beaten_carman : bool = false
## Construction Man has been defeated
var beaten_constructionman : bool = false
## Waffle Man has been defeated
var beaten_waffleman : bool = false
## Police Man has been defeated
var beaten_policeman : bool = false
## Lego Man has been defeated
var beaten_legoman : bool = false
## Cat Man has been defeated
var beaten_catman : bool = true
## Gold Man has been defeated
var beaten_goldman : bool = false
## 1st Wily stage has been cleared
var beaten_wily1 : bool = false
## 2nd Wily stage has been cleared
var beaten_wily2 : bool = false
## 3rd Wily stage has been cleared
var beaten_wily3 : bool = false

# Called when the node enters the scene tree for the first time.
# Sets the current scene and randomizes the RNG
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count() - 1)
	randomize()

## Changes the scene
func goto_scene(scene_name : Level):
	var path
	match scene_name:
		Level.START_MENU:
			path = "res://Menus/start_menu.tscn"
		Level.STAGE_SELECT:
			path = "res://Menus/stage_select_menu.tscn"
		Level.CONTINUE_MENU:
			path = "res://Menus/continue_menu.tscn"
		Level.BOWSER_MAN:
			path = "res://Levels/bowser_man_stage.tscn"
		Level.CAR_MAN:
			path = "res://Levels/car_man_stage.tscn"
		Level.CAT_MAN:
			path = "res://Levels/cat_man_stage.tscn"
		Level.TEST2:
			path = "res://Levels/test_level_2.tscn"
		Level.TEST_BOSS:
			path = "res://Levels/test_level_boss.tscn"
	
	call_deferred("_deferred_goto_scene", path)

## Restarts the current level
func restart_level():
	#call_deferred("_deferred_restart_scene")
	#get_tree().reload_current_scene()
	goto_scene(level_name) # workaround because reload_current_scene does not work becase Parameter "current_scene" is null somehow

#func _deferred_restart_scene():
#	curr_scene.get_tree().reload_current_scene()

## Removes all player shots, enemies, and enemy shots from the screen.
func clear_screen():
	for shot in get_tree().get_nodes_in_group("shots"):
		shot.queue_free()
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()
	for shot in get_tree().get_nodes_in_group("enemy_shots"):
		shot.queue_free()

# Loading a new scene needs to be in a call_deferred function
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	curr_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	curr_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(curr_scene)
