extends Node2D
@onready var score: Label = $CanvasLayer/ScoreBoard/Score
@onready var death: Label = $CanvasLayer/ScoreBoard/Death
@onready var char_scene : PackedScene = preload("res://scenes/char.tscn")
@onready var bgm: AudioStreamPlayer2D = $bgm
@onready var free_fall_timer: Timer = $FreeFallTimer

var current_index = 0


func _ready() -> void:
	score.text = "Score : " + str(SceneManager.score)
	death.text = "Death : " + str(SceneManager.death)
	
	if SceneManager.switch_bgm:
		bgm.autoplay = true
	else:
		bgm.playing = false
		bgm.autoplay = false
	
	var timer = Timer.new()
	timer.wait_time = 0.2
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	free_fall_timer.timeout.connect(_switch_text)

func _switch_text() -> void :
	current_index = (current_index + 1) % 2
	if current_index == 0:
		score.text = "Score : " + str(SceneManager.score)
	else:
		score.text = "Score : FreeFall"

func _on_timer_timeout():
	var character = char_scene.instantiate()
	character.position = Vector2(randf_range(0,576),0)
	add_child(character)

func _input(event: InputEvent) -> void:

	if event is InputEventKey and event.pressed:
		SceneManager.change_scene("res://scenes/main.tscn")
	if event is InputEventMouseButton and event.pressed:
		SceneManager.change_scene("res://scenes/main.tscn")
