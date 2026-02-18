extends Area2D
var pressionado : bool = false
@export var alvo_porta : Node2D 

func _ready() -> void:
	print(pressionado)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "body_marcaY":
		pressionado = true
		desativar_colisao_porta(true)

func desativar_colisao_porta(valor: bool):
	if alvo_porta:
		# Usamos o find_child para garantir que pegamos o nó de colisão correto
		var colisao = alvo_porta.find_child("collision")
		if colisao:
			# Usar set_deferred é obrigatório se a colisão mudar durante um impacto
			colisao.set_deferred("disabled", valor)
