extends Control

@export var icone1 : Sprite2D
@export var icone2 : Sprite2D
@export var icone3 : Sprite2D

func _ready() -> void:
	atualizar_tintas()

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
		
	if Input.is_action_just_pressed("UI_move_left"):
		Globals.corAtual = (Globals.corAtual - 1 + Globals.arrayTintas.size()) % Globals.arrayTintas.size()
		atualizar_tintas()
