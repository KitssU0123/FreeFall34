extends CharacterBody2D

@onready var anim = $AnimationPlayer
@onready var floor_detector: Area2D = $Floor_detector
@onready var sprite_2d: Sprite2D = $Sprite2D


const JUMP_VELOCITY = -100.0

var speed = 150.0
var gravity : int = 250
var score : int = 0
var can_move : bool = true

signal get_score

func _physics_process(delta):
	if modulate.a != 1 :
		speed = 0
	else:
		speed = 150
	if can_move == false:
		speed = 0
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y < 0:
			anim.play("jump")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	var direction = Input.get_axis("left", "right")
	if direction and can_move:
		velocity.x = direction * speed
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
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
				area.get_child(0).frame += 1
				area.can_get_score = false
	
	
