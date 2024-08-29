extends Node

@onready var music_player = $MusicPlayer

@onready var absorb_sound = $SoundPlayers/AbsorbSound
@onready var death_sound = $SoundPlayers/DeathSound
@onready var enemy_hurt_sound = $SoundPlayers/EnemyHurtSound
@onready var extra_life_sound = $SoundPlayers/ExtraLifeSound
@onready var fire_sound = $SoundPlayers/FireSound
@onready var gate_sound = $SoundPlayers/GateSound
@onready var landing_sound = $SoundPlayers/LandingSound
@onready var menu_sound = $SoundPlayers/MenuSound
@onready var player_hurt_sound = $SoundPlayers/PlayerHurtSound
@onready var player_shoot_sound = $SoundPlayers/PlayerShootSound
@onready var pause_sound = $SoundPlayers/PauseSound
@onready var recover_sound = $SoundPlayers/RecoverSound
@onready var reflected_sound = $SoundPlayers/ReflectedSound
@onready var stomp_sound = $SoundPlayers/StompSound

func play_music(path: String):
	music_player.stream = load(path)
	music_player.play()

func stop_music():
	music_player.stop()

func play_absorb_sound():
	absorb_sound.play()

func play_death_sound():
	death_sound.play()

func play_enemy_hurt_sound():
	enemy_hurt_sound.play()

func play_extra_life_sound():
	extra_life_sound.play()

func play_fire_sound():
	fire_sound.play()

func play_gate_sound():
	gate_sound.play()

func play_landing_sound():
	landing_sound.play()

func play_menu_sound():
	menu_sound.play()

func play_player_hurt_sound():
	player_hurt_sound.play()

func play_player_shoot_sound():
	player_shoot_sound.play()

func play_pause_sound():
	pause_sound.play()

func play_recover_sound():
	recover_sound.play()

func play_relected_sound():
	reflected_sound.play()

func play_stomp_sound():
	stomp_sound.play()

