extends StaticBody2D

@export var type : int = 0
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.frame = type
