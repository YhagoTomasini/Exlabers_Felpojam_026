extends Node2D

#Esse código serve para quando o player clicar na tela instanciar uma marca do carimbo,
#e ele está no objeto/cena/prefab "carimbo" que terá que estar em tds as fases

#Aui pega todas as opções de marcas do carimbo, que tem propriedades unicas
@onready var cenaMarcaC = preload("res://Prefabs/marcaC.tscn")
@onready var cenaMarcaM = preload("res://Prefabs/marcaM.tscn")
@onready var cenaMarcaY = preload("res://Prefabs/marcaY.tscn")
@onready var cenaMarcaK = preload("res://Prefabs/marcaK.tscn")

#Precisa pegar a referencia da UI para ativar uma função no código dela
@onready var ui_tintas: Control = %UI_Tintas
@onready var player = $"../PersonagemPrincipal"

#marca hipotetica
@onready var marcaHipoteticaCena = preload("res://Prefabs/marcaHipotetica.tscn")
var marcaHipotetica
@export var rangeMH : int = 32

#@export var aud : AudioStreamPlayer2D

#@onready var camera: Camera2D = %camera2

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_copy"):
		speedRun()
		
	if Input.is_action_pressed("clickRight"):
		if marcaHipotetica == null:
			marcaHipotetica = marcaHipoteticaCena.instantiate()
			add_child(marcaHipotetica)
		
		var joyStick_direcao = Input.get_vector("JoyStick_esquerda", "JoyStick_Direita", "JoyStick_Cima", "JoyStick_Baixo")
		var direcao = Vector2.ZERO
		
		if joyStick_direcao.length() > 0.2:
			direcao = joyStick_direcao.normalized()
		else:
			direcao = (get_local_mouse_position() - player.position).normalized()
		
		marcaHipotetica.position = player.position + direcao * rangeMH
		
	else:
		if marcaHipotetica != null:
			marcaHipotetica.queue_free()
			marcaHipotetica = null
		
	if Input.is_action_just_pressed("clickLeft") and marcaHipotetica != null:
		#Se existir a UI pede para ativar a função atualizar_barra nela
		if ui_tintas != null:
			ui_tintas.atualizar_barra()
		
		#instancia a marca dependendo da com atual, uma global que é alterada pelo codigo ui_tintas
		var marcaInstanciada
		#camera.shake(5)
		if Globals.corAtual == 0:
			marcaInstanciada = cenaMarcaK.instantiate()
			
		elif Globals.corAtual == 1:
			marcaInstanciada = cenaMarcaY.instantiate()
			
		elif Globals.corAtual == 2:
			marcaInstanciada = cenaMarcaM.instantiate()
			
		elif Globals.corAtual == 3:
			marcaInstanciada = cenaMarcaC.instantiate()
		
		AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.CARIMBO)
		
		marcaInstanciada.global_position = marcaHipotetica.position
		add_child(marcaInstanciada)
		
		
#############################

func speedRun():
	if !Globals.arrayTintas.has(Globals.amarelo):
		Globals.arrayTintas.append(Globals.amarelo)
	if !Globals.arrayTintas.has(Globals.magenta):
		Globals.arrayTintas.append(Globals.magenta)
	if !Globals.arrayTintas.has(Globals.ciano):
		Globals.arrayTintas.append(Globals.ciano)
	Globals.saveTanqueCena()
