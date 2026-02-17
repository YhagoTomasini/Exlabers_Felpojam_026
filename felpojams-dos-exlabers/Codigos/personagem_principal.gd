extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var noCianoB : bool
var noCianoI : int

func _ready() -> void:
	noCianoB = false
	noCianoI = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor() and !noCianoB:
		velocity += get_gravity() * delta
	elif not is_on_floor() and noCianoB:
		velocity += (get_gravity() * delta)/4

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and !noCianoB:
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("ui_up") and noCianoB:
		velocity.y = JUMP_VELOCITY/4

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_personagem_area_entered(area: Area2D) -> void:
	if area.name == "Area2DCiano":
		noCianoI += 1
		noCianoB = true
		

func _on_area_2d_personagem_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == "Area2DCiano":
		noCianoI -= 1
		if noCianoI <= 0:
			noCianoB = false
