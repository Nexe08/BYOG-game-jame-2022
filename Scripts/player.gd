extends KinematicBody2D

enum states {idle, run, attack}
var current_state = states.idle

export var speed := 100
export var gravity := 600
var velocity := Vector2.ZERO

onready var anim = $AnimatedSprite
onready var malee_range_collision_shape = $MaleeRange/CollisionShape2D


func _physics_process(delta: float) -> void:
	_state_change_condition()
	_state_logic(delta)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _state_change_condition():
	if _horizontal_input_direction() != 0:
		current_state = states.run
	else:
		current_state = states.idle
	
	if Input.is_action_pressed("space"):
		current_state = states.attack
	


func _state_logic(delta):
	match current_state:
		states.idle:
			malee_range_collision_shape.call_deferred("set_disabled", true)
			velocity.x = lerp(velocity.x, 0, 8 * delta)
			anim.play("idle")
		
		states.run:
			malee_range_collision_shape.call_deferred("set_disabled", true)
			velocity.x = lerp(velocity.x, speed * _horizontal_input_direction(), 5 * delta)
			anim.scale.x = _horizontal_input_direction()
			anim.play("run")
		
		states.attack:
			malee_range_collision_shape.call_deferred("set_disabled", false)
			velocity.x = lerp(velocity.x, 0, 8 * delta)
			anim.play("attack")


func _horizontal_input_direction():
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
