extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#temos uma booleana para verificação se esta na marca ciano,
#e uma inteira para verificar em quantos ciano o personagem esta
#por motivos similares da goma de mascar de Itsy Bitsy Spider
var noCianoB : bool
var noCianoI : int
var knockback_vector := Vector2.ZERO
var knockback_power := 20 

func _ready() -> void:
	noCianoB = false
	noCianoI = 0

func _physics_process(delta: float) -> void:
	#Se n estiver no chão e n estiver no ciano cai normal,
	if not is_on_floor() and !noCianoB:
		velocity += get_gravity() * delta
	#Se n estiver no chão e estiver no ciano cai devagar
	elif not is_on_floor() and noCianoB:
		velocity += (get_gravity() * delta)/4

	#Se estiver no chão e não estiver em um ciano pula normal
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and !noCianoB:
		velocity.y = JUMP_VELOCITY
	#Se estiver no ciano pode precionar que você sobe devagar... até sair do ciano
	elif Input.is_action_pressed("ui_up") and noCianoB:
		velocity.y = JUMP_VELOCITY/4

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
		var knockback = Vector2((global_position.x - area.global_position.x) * knockback_power, -200)
		empurra(knockback)

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
