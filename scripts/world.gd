extends Node2D
@onready var label: Label = $UI/Label
@onready var score_label: Label = $UI/Score

@onready var char_scene : PackedScene = preload("res://scenes/char.tscn")

@onready var main : PackedScene = preload("res://scenes/main.tscn")

var bpm: float = 138.0
var count: int = 0
var hp: int = 3
var score: int = 0
var character = char_scene
var score_flat : Array = []

var texts : Array = [
	"run","to","three","floors",
	"one","two","three","FALL!"
]

signal fall_plats
signal keep_level
signal change_level

func _ready() -> void:
	character = char_scene.instantiate()
	character.position = Vector2(144,100)
	add_child(character)
	
	label.text = texts[0]
	
	var timer = Timer.new()
	timer.wait_time = 60.0 / bpm  
	timer.one_shot = false  
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _physics_process(delta: float) -> void:
	character.get_score.connect(get_score)
	
	if hp <= 0:
		#SceneChanger.change_scece(main)
		print("you die")

func get_score() -> void:
	score += 1
	score_label.text = "Score : " + str(score)
	score_flat.append(0)
	

func _on_timer_timeout():
	count = (count + 1) % 8 
	label.text = texts[count]
	if count == 7 :
		fall_plats.emit()
	if count == 0 and score % 3 != 0:
		keep_level.emit()
	if count == 0 and score % 3 == 0:
		change_level.emit()



func _on_area_2d_body_entered(body: Node2D) -> void:
	
	hp -= 1
	print("hp " + str(hp))
	
	character.position = Vector2(144,100)
	add_child(character)
