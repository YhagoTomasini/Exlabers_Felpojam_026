extends Area2D
var pressionado : bool = false
@export var alvo_porta : Node2D 
@export var sprite : AnimatedSprite2D

var dentroBotao : int

func _ready() -> void:
	dentroBotao = 0
	
#func _physics_process(delta):
	#var corpo = get_overlapping_bodies()
	#
	#if corpo.size() > 0 and !pressionado:
		#print("hehe boi")
		#_on_body_entered(corpo[0])
	#
	#elif corpo.size() == 0 and pressionado:
		#_on_body_exited(null)


func desativar_colisao_porta(valor: bool):
	if alvo_porta:
		# Usamos o find_child para garantir que pegamos o nó de colisão correto
		var colisao = alvo_porta.find_child("collision")
		var portaAnim : AnimatedSprite2D = alvo_porta.find_child("sprite")
		
		if valor:
			#await get_tree().create_timer(1).timeout
			if portaAnim:
				portaAnim.play("aberta")
			if colisao:
				# Usar set_deferred é obrigatório se a colisão mudar durante um impacto
				colisao.set_deferred("disabled", valor)
			AudioManager.criar_aud_localizado(alvo_porta.position, SoundEffect.TIPO_DE_SOM.PORTA_ABRE)
				
		else:
			await get_tree().create_timer(1).timeout
			if dentroBotao > 0:
				return
				
			if portaAnim:
				portaAnim.play("default")
			if colisao:
				# Usar set_deferred é obrigatório se a colisão mudar durante um impacto
				colisao.set_deferred("disabled", valor)
			
			AudioManager.criar_aud_localizado(alvo_porta.position, SoundEffect.TIPO_DE_SOM.PORTA_FECHA)


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "body_marcaY" or body.name == "body_marcaP" or body.name == "body_marcaM":
		entrou_botao()

func _on_body_exited(body: Node2D) -> void:
	saiu_botao()

func _on_area_entered(area: Area2D) -> void:
	entrou_botao()

func _on_area_exited(area: Area2D) -> void:
	saiu_botao()
	
	
func entrou_botao():
	dentroBotao += 1
	
	sprite.play("apertado")
	verificarColisao()
	
	AudioManager.criar_aud_localizado(position, SoundEffect.TIPO_DE_SOM.BOTAO)
	desativar_colisao_porta(true)
		
func saiu_botao():
	dentroBotao -= 1
	#if dentroBotao <= 0:
		#pressionado = false
	sprite.play("default")
	
	AudioManager.criar_aud_localizado(position, SoundEffect.TIPO_DE_SOM.BOTAO)
	desativar_colisao_porta(false)
	
	verificarColisao()
	#dentroBotao = 0

func verificarColisao():
	if dentroBotao <= 0:
		pressionado = false
		dentroBotao = 0
	else:
		pressionado = true
