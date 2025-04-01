extends Node2D
@onready var score: Label = $CanvasLayer/ScoreBoard/Score
@onready var death: Label = $CanvasLayer/ScoreBoard/Death
@onready var char_scene : PackedScene = preload("res://scenes/char.tscn")
@onready var bgm: AudioStreamPlayer2D = $bgm
@onready var free_fall_timer: Timer = $FreeFallTimer
@onready var continue_label: Label = $CanvasLayer/ScoreBoard/Continue

var current_index = 0
var cont : bool = false

func _ready() -> void:
	score.text = "Score : " + str(SceneManager.score)
	death.text = "Death : " + str(SceneManager.death)
	
	if SceneManager.switch_bgm:
		bgm.autoplay = true
	else:
		bgm.playing = false
		bgm.autoplay = false
	
	continue_label.modulate.a = 0
	
	
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
	character.speed = 0
	character.can_move = false
	if int (character.position.x) % 2 == 1:
		character.get_child(0).flip_h = true
	add_child(character)

func _input(event: InputEvent) -> void:

	if event is InputEventKey and event.pressed:
		if cont == false:
			var t = get_tree().create_timer(1)
			create_tween().tween_property(continue_label, "modulate:a", 1.0, 1)
			await t.timeout
			cont = true
		else:
			SceneManager.change_scene("res://scenes/main.tscn")
	if event is InputEventMouseButton and event.pressed:
		if cont == false:
			var t = get_tree().create_timer(1)
			create_tween().tween_property(continue_label, "modulate:a", 1.0, 1)
			await t.timeout
			cont = true
		else:
			SceneManager.change_scene("res://scenes/main.tscn")
