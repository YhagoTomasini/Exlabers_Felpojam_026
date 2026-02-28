extends CharacterBody2D

const AIR_FRICTION := 0.7
const SPEED = 650.0
const MAGENTA_FORCE = -800.0

@export var anim : AnimatedSprite2D
@export var particulas_morte : CPUParticles2D
@export var particulas_andando : CPUParticles2D

@export var coyote_timer: Timer
@export var camera: Camera2D

var jump_heigh : float = 264
@export var max_time_to_peak := 0.5

#temos uma booleana para verificação se esta na marca ciano,
#e uma inteira para verificar em quantos ciano o personagem esta
#por motivos similares da goma de mascar de Itsy Bitsy Spider
var noCianoB : bool
var noCianoI : int

var knockback_vector := Vector2.ZERO
var knockback_power := 20 
var direction
var is_dead : bool = false
var push_force = 80.0

var jump_velocity
var gravity
var fall_gravity

var can_jump := true
var is_jumping := false
var estava_no_chao : bool = false
var puloConsumido : bool = false


func _ready() -> void:
	particulas_andando.emitting = false
	noCianoB = false
	noCianoI = 0
	jump_velocity= (jump_heigh*2)/ max_time_to_peak
	gravity= (jump_heigh*2)/ pow(max_time_to_peak,2)
	fall_gravity = gravity*2

func _physics_process(delta: float) -> void:
	#Se n estiver no chão e estiver no ciano cai devagar
	if not is_on_floor() and noCianoB:
		velocity += (get_gravity() * delta)/4
		is_jumping = false
	
	
	if is_on_floor():
		is_jumping = false
		puloConsumido = false
		
	if estava_no_chao and !is_on_floor():
		coyote_timer.start()
	estava_no_chao = is_on_floor()
	
	
	#Se estiver no chão e não estiver em um ciano pula normal
	if Input.is_action_just_pressed("ui_up") and !is_jumping and !noCianoB and !puloConsumido:
		if is_on_floor() or !coyote_timer.is_stopped():
			velocity.y = -jump_velocity
			is_jumping = true
			
			puloConsumido = true
			coyote_timer.stop()
			
	#Se estiver no ciano pode precionar que você sobe devagar... até sair do ciano
	elif Input.is_action_pressed("ui_up") and noCianoB:
		velocity.y = -jump_velocity/4
	
	
	if velocity.y > 0 or not Input.is_action_pressed("ui_up"):
		velocity.y += fall_gravity*delta
	else:
		velocity.y += gravity*delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, AIR_FRICTION)
		anim.flip_h = (direction<0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
		
	_set_state()
	
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)

func _on_area_2d_personagem_area_entered(area: Area2D) -> void:
	#Passar de Lvl e recebe uma nova cor de tinta
	if area.name == "FinalLvl1":
		Transição.anim_in()
		await Transição.anim.animation_finished
		
		if !Globals.arrayTintas.has(Globals.amarelo):
			Globals.arrayTintas.append(Globals.amarelo)
		Globals.saveTanqueCena()
		get_tree().call_deferred("change_scene_to_file","res://Cenas/lvl_2.tscn")

	elif area.name == "FinalLvl2":
		Transição.anim_in()
		await Transição.anim.animation_finished
		
		if !Globals.arrayTintas.has(Globals.magenta):
			Globals.arrayTintas.append(Globals.magenta)
		Globals.saveTanqueCena()
		get_tree().call_deferred("change_scene_to_file","res://Cenas/lvl_3.tscn")

	elif area.name == "FinalLvl3":
		Transição.anim_in()
		await Transição.anim.animation_finished
		
		if !Globals.arrayTintas.has(Globals.ciano):
			Globals.arrayTintas.append(Globals.ciano)
		Globals.saveTanqueCena()
		get_tree().call_deferred("change_scene_to_file","res://Cenas/lvl_4.tscn")

	elif area.name == "FinalLvl4":
		Globals.finalizou = true
		
		Transição.anim_in()
		await Transição.anim.animation_finished
		
		get_tree().call_deferred("change_scene_to_file","res://Cenas/tela_creditos.tscn")

	
	#Verificação da colisão com o ciano por area2D :D
	elif area.is_in_group("agua"):
		noCianoI += 1
		noCianoB = true
		
	elif area.name == "Area2DMagenta":
		is_jumping = true
		velocity.y = MAGENTA_FORCE*1.7
		area.bounce()
		#var knockback = Vector2((global_position.x - area.global_position.x) * knockback_power, -200)
		#empurra(knockback)
		#Só comentar e descomentar se quiser voltar o knocback

func _on_area_2d_personagem_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area != null:
		if area.is_in_group("agua"):
			noCianoI -= 1
			if noCianoI <= 0:
				noCianoB = false

#func empurra(knockback_force := Vector2.ZERO,duration := 0.25):
	#if knockback_force != Vector2.ZERO:
		#knockback_vector = knockback_force
		#var knockback_tween := get_tree().create_tween()
		#knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)

func _set_state():
	var state = "Idle"
	var efeitoSom  = null
	particulas_andando.emitting = false
	if !noCianoB:
		AudioManager.destruir_novo_aud(SoundEffect.TIPO_DE_SOM.AGUA)
	if !is_on_floor():
		if !noCianoB:
			AudioManager.destruir_novo_aud(SoundEffect.TIPO_DE_SOM.AGUA)
		
			if velocity.y < 0:
				if is_jumping:
					state = "Jump"
					efeitoSom = SoundEffect.TIPO_DE_SOM.PULO
					
					particulas_andando.emitting = true
					
					jump_tween()
				
			else:
				particulas_andando.emitting = false
				state = "Falling"
				queda_tween()
				
		else:
			state = "Nadando"
			efeitoSom = SoundEffect.TIPO_DE_SOM.AGUA
			
	elif velocity.x != 0:
		state = "Run"
		particulas_andando.emitting = true
		efeitoSom = SoundEffect.TIPO_DE_SOM.PASSO
		
	if anim.name != state:
		anim.play(state)
		if efeitoSom != null:
			AudioManager.criar_aud(efeitoSom)
	
	
func player_morreu():
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.MORTE)
	
	anim.visible = false
	set_physics_process(false)
	particulas_morte.emitting = true
	camera.shake(20)
	await get_tree().create_timer(1).timeout
	Globals.refil_de_tinta()
	get_tree().call_deferred("reload_current_scene")

func jump_tween():
	var tween = create_tween()
	tween.tween_property(anim, "scale", Vector2(0.8, 1.2), 0.1)
	tween.tween_property(anim, "scale", Vector2.ONE, 0.05)

func queda_tween():
	var tween = create_tween()
	tween.tween_property(anim, "scale", Vector2(1.2, 0.8), 0.1)
	tween.tween_property(anim, "scale", Vector2.ONE, 0.05)

#func _on_coyote_timer_timeout() -> void:
	#can_jump = false
