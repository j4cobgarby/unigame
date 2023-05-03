extends CharacterBody2D


const SPEED = 60.0
const JUMP_VELOCITY = -170.0
const LADDER_SPEED = 60

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_climb = false

func _ready():
	Main.set_player_body(self)
	$sprite.play("idle")

func focus_cam():
	$cam_follow.make_current()

func rescue_possible(rescuable):
	print("Player may pick up ", rescuable, " which is worth ", rescuable.worth)

func _process(delta):
	if not is_on_floor() and not can_climb:
		velocity.y += gravity * delta
		
	if can_climb:
		if Input.is_action_pressed("ui_up"):
			velocity.y = -LADDER_SPEED
		elif Input.is_action_pressed("ui_down"):
			velocity.y = LADDER_SPEED
		else:
			velocity.y = 0

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$sprite.play("running")
		$sprite.scale = Vector2(-1, 1)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$sprite.play("running")
		$sprite.scale = Vector2(1, 1)
	else:
		$sprite.play("idle")
		velocity.x = 0

func _physics_process(delta):

	move_and_slide()
