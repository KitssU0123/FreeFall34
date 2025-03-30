extends Node2D
@onready var score: Label = $CanvasLayer/ScoreBoard/Score
@onready var death: Label = $CanvasLayer/ScoreBoard/Death
@onready var char_scene : PackedScene = preload("res://scenes/char.tscn")
@onready var bgm: AudioStreamPlayer2D = $bgm

func _ready() -> void:
	score.text = "Score : " + str(SceneManager.score)
	death.text = "Death : " + str(SceneManager.death)
	var timer1 = Timer.new()
	timer1.wait_time = 0.2
	timer1.one_shot = false
	timer1.timeout.connect(_on_timer1_timeout)
	add_child(timer1)
	timer1.start()
	if SceneManager.switch_bgm:
		bgm.autoplay = true
	else:
		bgm.playing = false
		bgm.autoplay = false
	
func _physics_process(delta: float) -> void:
	
	var timer = get_tree().create_timer(1)
	await timer.timeout
	score.text = "Score : FreeFall"


func _on_timer1_timeout():
	var character = char_scene.instantiate()
	character.position = Vector2(randf_range(0,576),0)
	add_child(character)
	
	
	
func _input(event: InputEvent) -> void:

	if event is InputEventKey and event.pressed:
		SceneManager.change_scene("res://scenes/main.tscn")
	if event is InputEventMouseButton and event.pressed:
		SceneManager.change_scene("res://scenes/main.tscn")
