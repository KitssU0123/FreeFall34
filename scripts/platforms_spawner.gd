class_name Spawner
extends Node

@onready var platforms : PackedScene = preload("res://scenes/platform.tscn")
@onready var world: Node2D = $".."

var levels = [
	[1, 0, 1, 0, 1, 1, 0], # 第1關
	[0, 1, 0, 1, 1, 0, 1], # 第2關
	[0, 1, 1, 0, 0, 1, 1], # 第3關
	
	[2, 1, 2, 2, 1, 2, 1], # 第4關
	[2, 1, 2, 1, 1, 2, 2], # 第5關
	[1, 2, 1, 2, 2, 1, 2], # 第6關
	
	[2, 3, 3, 2, 3, 3, 2], # 第7關
	[3, 2, 2, 3, 3, 2, 3], # 第8關
	[2, 3, 2, 3, 3, 2, 3], # 第9關
	
	[4, 3, 4, 3, 4, 3, 4], # 第10關
	[3, 4, 4, 3, 4, 4, 3], # 第11關
]

var element: int = 0
var total_width : int = 288
var platform_count : int =  7
var level_count : int = 11
var count = 0
var spacing = total_width / (platform_count+1)

var current_level_score : int = 3


func _ready() -> void:
	for i in platform_count:
		var plats = platforms.instantiate()
		add_child(plats)
		plats.position.x =  spacing * (i+1)
		plats.position.y = 120
		var current_level: Array = levels[count]
		var sprite2d = plats.get_child(0)
		sprite2d.frame = current_level[i]
		if current_level[i] == element:
			plats.can_get_score = true

func _physics_process(delta: float) -> void:
	world.fall_plats.connect(fall)
	world.keep_level.connect(keep)
	world.change_level.connect(change)

func fall() -> void: 
	for child in get_children():
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(child, "position", Vector2(child.position.x,300), 0.5)

func keep() -> void:
	for child in get_children():
		#child.position = Vector2(child.position.x,120)
		var tween = create_tween()
		tween.tween_property(child, "position", Vector2(child.position.x,120), 0.2)

func change() -> void:
	if count == level_count - 1:
		print("end game")
		return
	print("change level")
	for child in get_children():
		child.queue_free()
		
	count += 1
	element = (count / 3 ) % 4
	
	for i in platform_count:
		var plats = platforms.instantiate()
		add_child(plats)
		plats.modulate.a = 0
		plats.position.x =  spacing * (i+1)
		plats.position.y = 120
		var current_level: Array = levels[count]
		var sprite2d = plats.get_child(0)
		sprite2d.frame = current_level[i]
		var tween = create_tween()
		tween.tween_property(plats, "modulate:a", 1 , 0.5)
		
		if current_level[i] == element:
			plats.can_get_score = true
		
