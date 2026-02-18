extends CharacterBody2D


const SPEED = 300.0
const MAGENTA_FORCE = -400.0
const AIR_FRICTION := 0.7

#temos uma booleana para verificação se esta na marca ciano,
#e uma inteira para verificar em quantos ciano o personagem esta
#por motivos similares da goma de mascar de Itsy Bitsy Spider
var noCianoB : bool
var noCianoI : int
var knockback_vector := Vector2.ZERO
var knockback_power := 20 

var is_jumping := false
@export var jump_heigh := 128
@export var max_time_to_peak := 0.5
var jump_velocity
var gravity
var fall_gravity


func _ready() -> void:
	noCianoB = false
	noCianoI = 0
	jump_velocity= (jump_heigh*2)/ max_time_to_peak
	gravity= (jump_heigh*2)/ pow(max_time_to_peak,2)
	fall_gravity = gravity*2

func _physics_process(delta: float) -> void:
	#Se n estiver no chão e n estiver no ciano cai normal,
	if not is_on_floor() and !noCianoB:
		velocity.x = 0
	#Se n estiver no chão e estiver no ciano cai devagar
	elif not is_on_floor() and noCianoB:
		velocity += (get_gravity() * delta)/4

	#Se estiver no chão e não estiver em um ciano pula normal
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and !noCianoB:
		velocity.y = -jump_velocity
		is_jumping = true
	#Se estiver no ciano pode precionar que você sobe devagar... até sair do ciano
	elif Input.is_action_pressed("ui_up") and noCianoB:
		velocity.y = -jump_velocity/4
	elif is_on_floor():
		is_jumping = false
		
	if velocity.y > 0 or not Input.is_action_pressed("ui_up"):
		velocity.y += fall_gravity*delta
	else:
		velocity.y += gravity*delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	move_and_slide()

func _on_area_2d_personagem_area_entered(area: Area2D) -> void:
	#Passar de Lvl e recebe uma nova cor de tinta
	if area.name == "FinalLvl1":
		Globals.arrayTintas.append(Globals.amarelo)
		#get_tree().change_scene_to_file("res://Cenas/sala_de_testes.tscn")
		area.queue_free()
	elif area.name == "FinalLvl2":
		Globals.arrayTintas.append(Globals.magenta)
		#get_tree().change_scene_to_file("res://Cenas/sala_de_testes.tscn")
		area.queue_free()
	elif area.name == "FinalLvl3":
		Globals.arrayTintas.append(Globals.ciano)
		#get_tree().change_scene_to_file("res://Cenas/sala_de_testes.tscn")
		area.queue_free()
	
	#Verificação da colisão com o ciano por area2D :D
	elif area.name == "Area2DCiano":
		noCianoI += 1
		noCianoB = true
		
	elif area.name == "Area2DMagenta":
		#var knockback = Vector2((global_position.x - area.global_position.x) * knockback_power, -200)
		#empurra(knockback)
		#Só comentar e descomentar se quiser voltar o knocback
		velocity.y = MAGENTA_FORCE*1.7

func _on_area_2d_personagem_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area != null:
		if area.name == "Area2DCiano":
			noCianoI -= 1
			if noCianoI <= 0:
				noCianoB = false

func empurra(knockback_force := Vector2.ZERO,duration := 0.25):
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		

func player_morreu():
	Globals.refil_de_tinta()
	get_tree().call_deferred("reload_current_scene")
