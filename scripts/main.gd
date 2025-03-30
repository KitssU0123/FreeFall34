extends Node2D

const WORLD = preload("res://scenes/world.tscn")

func _on_start_button_pressed() -> void:
	SceneChanger.change_scece(WORLD)

func _on_settings_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
