extends CharacterBody2D

@onready var anim = $AnimationPlayer

const SPEED = 150.0
const JUMP_VELOCITY = -150.0  # 增加初始跳躍速度

var gravity = 500 

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
		# 根據移動方向翻轉精靈
		$Sprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_on_floor() and velocity.x == 0:
		anim.play("idle")

	move_and_slide()
