extends Node2D

@onready var volume_toggle: Button = $UI/Control/VBoxContainer/HBoxContainer/VBoxContainer/VolumeToggle



func _ready():
	if SceneManager.switch_bgm:
		volume_toggle.text = "On"
	else:
		volume_toggle.text = "Off"
		
	volume_toggle.toggled.connect(_on_volume_toggle_toggled)

func _on_volume_toggle_toggled(button_pressed: bool):
	SceneManager.switch_bgm = button_pressed
	if SceneManager.switch_bgm:
		volume_toggle.text = "On"
	else:
		volume_toggle.text = "Off"
	#print(SceneManager.switch_bgm)



func _on_back_button_pressed():
	SceneManager.change_scene("res://scenes/main.tscn")
