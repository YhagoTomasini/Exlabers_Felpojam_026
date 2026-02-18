extends Area2D
var pressionado : bool = false
@export var alvo_porta : Node2D 
@export var sprite : AnimatedSprite2D

func _ready() -> void:
	print(pressionado)


func desativar_colisao_porta(valor: bool):
	if alvo_porta:
		# Usamos o find_child para garantir que pegamos o nó de colisão correto
		var colisao = alvo_porta.find_child("collision")
		var portaAnim : AnimatedSprite2D = alvo_porta.find_child("sprite")
		
		if valor:
			if portaAnim:
				portaAnim.play("aberta")
			if colisao:
				# Usar set_deferred é obrigatório se a colisão mudar durante um impacto
				colisao.set_deferred("disabled", valor)
				
		else:
			if portaAnim:
				portaAnim.play("default")
			if colisao:
				# Usar set_deferred é obrigatório se a colisão mudar durante um impacto
				colisao.set_deferred("disabled", valor)


func _on_body_entered(body: Node2D) -> void:
	#if body.name == "body_marcaY":
	pressionado = true
	sprite.play("apertado")
	
	desativar_colisao_porta(true)

func _on_body_exited(body: Node2D) -> void:
	pressionado = false
	sprite.play("default")
	
	desativar_colisao_porta(false)
