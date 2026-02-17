extends Node2D

@onready var cenaMarcaC = preload("res://Prefabs/marcaC.tscn")
@onready var cenaMarcaM = preload("res://Prefabs/marcaM.tscn")
@onready var cenaMarcaY = preload("res://Prefabs/marcaY.tscn")
@onready var cenaMarcaK = preload("res://Prefabs/marcaK.tscn")
@onready var uiTntas = $"../UI_Tintas"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		if uiTntas != null:
			uiTntas.atualizar_barra()
			
		var marcaInstanciada
		
		if Globals.corAtual == 0:
			marcaInstanciada = cenaMarcaK.instantiate()
			
		elif Globals.corAtual == 1:
			marcaInstanciada = cenaMarcaM.instantiate()
			
		elif Globals.corAtual == 2:
			marcaInstanciada = cenaMarcaY.instantiate()
			
		elif Globals.corAtual == 3:
			marcaInstanciada = cenaMarcaC.instantiate()
			
		marcaInstanciada.global_position = get_local_mouse_position()
		add_child(marcaInstanciada)
	
