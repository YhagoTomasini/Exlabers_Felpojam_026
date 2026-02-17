extends Node2D

#Esse código serve para quando o player clicar na tela instanciar uma marca do carimbo,
#e ele está no objeto/cena/prefab "carimbo" que terá que estar em tds as fases

#Aui pega todas as opções de marcas do carimbo, que tem propriedades unicas
@onready var cenaMarcaC = preload("res://Prefabs/marcaC.tscn")
@onready var cenaMarcaM = preload("res://Prefabs/marcaM.tscn")
@onready var cenaMarcaY = preload("res://Prefabs/marcaY.tscn")
@onready var cenaMarcaK = preload("res://Prefabs/marcaK.tscn")

#Precisa pegar a referencia da UI para ativar uma função no código dela
@onready var uiTntas = $"../UI_Tintas"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#Clica
	if Input.is_action_just_pressed("click"):
		#Se existir a UI pede para ativar a função atualizar_barra nela
		if uiTntas != null:
			uiTntas.atualizar_barra()
		
		#instaancia a marca dependendo da com atual, uma global que é alterada pelo codigo ui_tintas
		var marcaInstanciada
		
		if Globals.corAtual == 0:
			marcaInstanciada = cenaMarcaK.instantiate()
			
		elif Globals.corAtual == 1:
			marcaInstanciada = cenaMarcaM.instantiate()
			
		elif Globals.corAtual == 2:
			marcaInstanciada = cenaMarcaY.instantiate()
			
		elif Globals.corAtual == 3:
			marcaInstanciada = cenaMarcaC.instantiate()
		
		marcaInstanciada.global_position = get_local_mouse_position() #instancia na posição do mouse
		add_child(marcaInstanciada)
