extends Node2D
@onready var bgm: AudioStreamPlayer2D = $bgm

func _ready() -> void:
	if SceneManager.switch_bgm:
		bgm.autoplay = true
	else:
		bgm.playing = false
		bgm.autoplay = false

func _on_start_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/world.tscn")

func _on_settings_button_pressed() -> void:
	SceneManager.change_scene("res://scenes/settings.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
