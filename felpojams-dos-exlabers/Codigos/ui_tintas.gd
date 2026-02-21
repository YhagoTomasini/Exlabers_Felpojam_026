extends Control

#código dos icones interativos das tintas da UI

#Pego os objetos que vai ser afetados pelo código
@export var icone1 : TextureRect
@export var icone2 : TextureRect
@export var icone3 : TextureRect

@export var barra : Sprite2D

func _ready() -> void:
	atualizar_tintas()
	atualizar_barra()

#Essa função serve para atualizar a barra de nivel de cada tinta nos carimbos,
#uma forma visual de mostrar para o player que a tinta esta acabando
func atualizar_barra():
	await get_tree().create_timer(0.1).timeout #ISSO AQUI É DEUS NA TERRA
	
	var estoqueAtual : float
	
	#Sempre que chamado irá verificar qual a tinta atual
	if Globals.corAtual == 0:
		barra.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
		estoqueAtual = Globals.tanqueTintaPreta
		
	elif Globals.corAtual == 2:
		estoqueAtual = Globals.tanqueTintaMagenta
		barra.self_modulate = Color(1.0, 0.0, 1.0, 1.0)
		
	elif Globals.corAtual == 1:
		estoqueAtual = Globals.tanqueTintaAmarelo
		barra.self_modulate = Color(1.0, 1.0, 0.0, 1.0)
		
	elif Globals.corAtual == 3:
		estoqueAtual = Globals.tanqueTintaCiano
		barra.self_modulate = Color(0.0, 1.0, 1.0, 1.0)
	
	#e escala ela baseado no maximo que teria de tinta e a quantidadde de tinta atual
	barra.scale.y = (estoqueAtual / Globals.maxTanque)*1.5
	
	print(Globals.barraEstoqueSize)

#Essa função serve para conseguir mudar qual tinta o player vai usar
func atualizar_tintas():
	#Equações para verificar qual a index do array é a tinta da esquerda e da direita
	var esquerda = (Globals.corAtual - 1 + Globals.arrayTintas.size()) % Globals.arrayTintas.size()
	var direita = (Globals.corAtual + 1) % Globals.arrayTintas.size()
	
	icone1.texture = Globals.arrayTintas[esquerda]
	icone2.texture = Globals.arrayTintas[Globals.corAtual]
	icone3.texture = Globals.arrayTintas[direita]
	
func _process(delta: float) -> void:
	#vai para a cor que esta a direita da atual
	if Input.is_action_just_pressed('UI_move_right'):
		Globals.corAtual = (Globals.corAtual + 1) % Globals.arrayTintas.size()
		atualizar_tintas()
		atualizar_barra()
	
	#vai para a cor que esta a esquerda da atual
	if Input.is_action_just_pressed("UI_move_left"):
		Globals.corAtual = (Globals.corAtual - 1 + Globals.arrayTintas.size()) % Globals.arrayTintas.size()
		atualizar_tintas()
		atualizar_barra()
