extends Control

@export var icone1 : Sprite2D
@export var icone2 : Sprite2D
@export var icone3 : Sprite2D
@export var barra : Sprite2D

func _ready() -> void:
	atualizar_tintas()
	atualizar_barra()

func atualizar_barra():
	await get_tree().create_timer(0.1).timeout #ISSO AQUI É DEUS NA TERRA
	
	var estoqueAtual : float
	
	if Globals.corAtual == 0:
		estoqueAtual = Globals.tanqueTintaPreta
		
	elif Globals.corAtual == 1:
		estoqueAtual = Globals.tanqueTintaMagenta
		
	elif Globals.corAtual == 2:
		estoqueAtual = Globals.tanqueTintaAmarelo
		
	elif Globals.corAtual == 3:
		estoqueAtual = Globals.tanqueTintaCiano

	barra.texture = Globals.arrayTintas[Globals.corAtual]
	barra.scale.y = estoqueAtual / Globals.maxTanque
	
	print(Globals.barraEstoqueSize)

func atualizar_tintas():
	var esquerda = (Globals.corAtual - 1 + Globals.arrayTintas.size()) % Globals.arrayTintas.size()
	var direita = (Globals.corAtual + 1) % Globals.arrayTintas.size()
	
	
	icone1.texture = Globals.arrayTintas[esquerda]
	icone2.texture = Globals.arrayTintas[Globals.corAtual]
	icone3.texture = Globals.arrayTintas[direita]
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('UI_move_right'):
		Globals.corAtual = (Globals.corAtual + 1) % Globals.arrayTintas.size()
		atualizar_tintas()
		atualizar_barra()
		
	if Input.is_action_just_pressed("UI_move_left"):
		Globals.corAtual = (Globals.corAtual - 1 + Globals.arrayTintas.size()) % Globals.arrayTintas.size()
		atualizar_tintas()
		atualizar_barra()
