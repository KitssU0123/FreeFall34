extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()
	
func change_scece(path) -> void:
	show()
	set_layer(100)
	anim.play("change")
	await anim.animation_finished
	get_tree().change_scene_to_packed(path)
	anim.play_backwards("change")
	await anim.animation_finished
	set_layer(-1)
	hide()
	
