extends Node
## An autoload manager for all the sounds in the game

@onready var music_player = $MusicPlayer ## AudioStreamPlayer for the music

@onready var absorb_sound = $SoundPlayers/AbsorbSound ## AudioStreamPlayer for the absorb sound
@onready var death_sound = $SoundPlayers/DeathSound ## AudioStreamPlayer for the death sound
@onready var enemy_hurt_sound = $SoundPlayers/EnemyHurtSound ## AudioStreamPlayer for the enemy hurt sound
@onready var enemy_shoot_sound = $SoundPlayers/EnemyShootSound ## AudioStreamPlayer for the enemy shoot sound
@onready var extra_life_sound = $SoundPlayers/ExtraLifeSound ## AudioStreamPlayer for the extra life sound
@onready var fire_sound = $SoundPlayers/FireSound ## AudioStreamPlayer for the fire sound
@onready var gate_sound = $SoundPlayers/GateSound ## AudioStreamPlayer for the gate sound
@onready var honk_sound = $SoundPlayers/HonkSound ## AudioStreamPlayer for the honk sound
@onready var landing_sound = $SoundPlayers/LandingSound ## AudioStreamPlayer for the landing sound
@onready var menu_sound = $SoundPlayers/MenuSound ## AudioStreamPlayer for the menu sound
@onready var player_hurt_sound = $SoundPlayers/PlayerHurtSound ## AudioStreamPlayer for the player hurt sound
@onready var player_shoot_sound = $SoundPlayers/PlayerShootSound ## AudioStreamPlayer for the player shoot sound
@onready var pause_sound = $SoundPlayers/PauseSound ## AudioStreamPlayer for the pause sound
@onready var recover_sound = $SoundPlayers/RecoverSound ## AudioStreamPlayer for the recover sound
@onready var reflected_sound = $SoundPlayers/ReflectedSound ## AudioStreamPlayer for the reflected sound
@onready var slash_sound = $SoundPlayers/SlashSound ## AudioStreamPlayer for the slash sound
@onready var stomp_sound = $SoundPlayers/StompSound ## AudioStreamPlayer for the stomp sound

## Plays the music for the given path string
func play_music(path: String):
	music_player.stream = load(path)
	music_player.play()

## Stops playing the music
func stop_music():
	music_player.stop()

## Plays the absorb sound
func play_absorb_sound():
	absorb_sound.play()

## Plays the death sound
func play_death_sound():
	death_sound.play()

## Plays the enemy hurt sound
func play_enemy_hurt_sound():
	enemy_hurt_sound.play()

## Plays the enemy shoot sound
func play_enemy_shoot_sound():
	enemy_shoot_sound.play()

## Plays the extra life sound
func play_extra_life_sound():
	extra_life_sound.play()

## Plays the fire sound
func play_fire_sound():
	fire_sound.play()

## Plays the gate sound
func play_gate_sound():
	gate_sound.play()

## Plays the honk sound
func play_honk_sound():
	honk_sound.play()

## Plays the landing sound
func play_landing_sound():
	landing_sound.play()

## Plays the menu sound
func play_menu_sound():
	menu_sound.play()

## Plays the player hurt sound
func play_player_hurt_sound():
	player_hurt_sound.play()

## Plays the player shoot sound
func play_player_shoot_sound():
	player_shoot_sound.play()

## Plays the pause sound
func play_pause_sound():
	pause_sound.play()

## Plays the recover sound
func play_recover_sound():
	recover_sound.play()

## Plays the reflected sound
func play_relected_sound():
	reflected_sound.play()

## Plays the slash sound
func play_slash_sound():
	slash_sound.play()

## Plays the stomp sound
func play_stomp_sound():
	stomp_sound.play()

