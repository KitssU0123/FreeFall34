extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var floor_detector: Area2D = $Floor_detector

const SPEED = 150.0
const JUMP_VELOCITY = -100.0

var gravity : int = 250
var score : int = 0

signal get_score

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			anim.play("jump")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor() and velocity.x == 0:
		anim.play("idle")
	if anim.is_playing() and anim.current_animation != "jump" and not is_on_floor():
		anim.play("fall")
		
	move_and_slide()	
	check_floor()
	
func check_floor() -> void :
	var areas = floor_detector.get_overlapping_bodies()
	for area in areas:
		if "can_get_score" in area:
			if area.can_get_score:
				get_score.emit()
				area.can_get_score = false
	
	
