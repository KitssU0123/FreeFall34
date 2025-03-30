extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

var score : int = 0
var death : int = 0
var switch_bgm : bool = true

func _ready() -> void:
	hide()
	
func change_scene(path) -> void:
	show()
	set_layer(100)
	anim.play("change")
	await anim.animation_finished
	get_tree().change_scene_to_file(path)
	anim.play_backwards("change")
	await anim.animation_finished
	set_layer(-1)
	hide()
	
