extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(float) var speed

func _ready():
	$Timer.connect("timeout", self, "anim")

func anim ():
	$Ghost.frame = 1 - $Ghost.frame

func _process(delta):
	var vel = Vector2 (0, 0)
	if Input.is_key_pressed(KEY_W):
		vel = vel + Vector2(0, -speed)
	elif Input.is_key_pressed(KEY_A):
		vel = vel + Vector2(-speed, 0)
		$Ghost.flip_h = false
	elif Input.is_key_pressed(KEY_S):
		vel = vel + Vector2(0, speed)
	elif Input.is_key_pressed(KEY_D):
		vel = vel + Vector2(speed, 0)
		$Ghost.flip_h = true
	var np = position + vel
	var w = np.x
	var h = np.y
	if w > 0 and w < get_viewport_rect().size.x:
		if h > 0 and h < get_viewport_rect().size.y:
			move_and_collide(vel)
		else:
			if h < 0:
				position.y = abs (position.y)
			else:
				position.y = get_viewport().size.y - 10
	else:
		if w < 0:
			position.x = abs (position.x)
		else:
			position.x = get_viewport().size.x - 10
