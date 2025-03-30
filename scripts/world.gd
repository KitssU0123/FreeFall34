extends Node2D
class_name world
@onready var label: Label = $UI/Label
@onready var score_label: Label = $UI/Score
@onready var level: Label = $UI/Level
@onready var death_label: Label = $UI/Death

@onready var color_rect: ColorRect = $ColorRect


@onready var plat1: plat = $"static plat/Platform"
@onready var plat2: plat = $"static plat/Platform2"
@onready var bgm: AudioStreamPlayer2D = $bgm


@onready var char_scene : PackedScene = preload("res://scenes/char.tscn")

const MAIN = preload("res://scenes/main.tscn")

var bpm: float = 138.0
var count: int = 0
var death: int = 0
var score: int = 0
var character = char_scene
var current_level : int = 1
var can_change : bool = false

var colors : Array = [
	Color.MEDIUM_PURPLE,
	Color.YELLOW,
	Color.SKY_BLUE,
	Color.PALE_VIOLET_RED
	]

var texts : Array = [
	"run","to","three","floors",
	"one","two","three","FALL!"
]

signal fall_plats
signal keep_level
signal change_level

func _ready() -> void:
	character = char_scene.instantiate()
	character.position = Vector2(8,100)
	add_child(character)
	
	if SceneManager.switch_bgm:
		bgm.autoplay = true
	else:
		bgm.playing = false
		bgm.autoplay = false
	
	label.text = texts[0]
	level.text = "Level : 1"
	score_label.text = "Score : 0"
	death_label.text = "Death : 0"
	
	color_rect.color = colors[0]
	
	plat1.get_child(0).frame = 1
	plat2.get_child(0).frame = 1
	
	var timer = Timer.new()
	timer.wait_time = 60.0 / bpm  
	timer.one_shot = false  
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _physics_process(delta: float) -> void:
	character.get_score.connect(get_score)
	if Input.is_action_just_pressed("back"):
		SceneManager.change_scene("res://scenes/main.tscn")


func get_score() -> void:
	 
	score += 1
	SceneManager.score = score
	score_label.text = "Score : " + str(score)
	if current_level != score / 3 + 1 :
		can_change = true
		current_level += 1
	

func _on_timer_timeout():
	count = (count + 1) % 8 
	label.text = texts[count]
	if count == 7 :
		fall_plats.emit()
	if count == 0 and can_change == false:
		level.text = "Level : " + str(current_level)
		keep_level.emit()
	if count == 0 and  can_change == true:
		level.text = "Level : " + str(current_level)
		can_change = false
		change_level.emit()
		var tween = create_tween()
		tween.tween_property(color_rect, "color", colors[( current_level - 1 ) / 3 ], 0.5)
		plat1.get_child(0).frame = ( current_level - 1 ) / 3 + 1
		plat2.get_child(0).frame = ( current_level - 1 ) / 3 + 1
	
	if score == 34:
		SceneManager.change_scene("res://scenes/ending.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	death += 1
	SceneManager.death = death
	death_label.text = "Death : " + str(death)
	#print("death " + str(death))
	#SceneManager.change_scene("res://scenes/main.tscn")
	if character.position.x < 576/4 :
		character.position = Vector2(8,0)
	else :
		character.position = Vector2(280,0)
	character.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 1 , 0.5)
	add_child(character)
