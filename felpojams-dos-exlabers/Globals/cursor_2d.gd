extends CanvasLayer

@onready var cursor : Sprite2D = $Sprite2D2

func _ready() -> void:
	cor_cursor()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func cor_cursor():
	if Globals.corAtual == 0:
		cursor.self_modulate = Color(0.157, 0.157, 0.267, 1.0)
		
	elif Globals.corAtual == 2:
		cursor.self_modulate = Color(1.0, 0.0, 1.0, 1.0)
		
	elif Globals.corAtual == 1:
		cursor.self_modulate = Color(1.0, 1.0, 0.0, 1.0)
		
	elif Globals.corAtual == 3:
		cursor.self_modulate = Color(0.0, 1.0, 1.0, 1.0)
	
func _process(delta: float) -> void:
	cursor.position = get_viewport().get_mouse_position()
	
	#helps
	if Input.is_action_just_pressed("ui_copy"):
		Globals.speedRun()
	
	if Input.is_action_just_pressed("ui_paste"):
		Globals.dados.finalizou = true
		Globals.salvar_jogo()
		get_tree().call_deferred("change_scene_to_file","res://Cenas/tela_inicial.tscn")
	
	if Input.is_action_just_pressed("ui_cut"):
		Globals.apagar_save()
		get_tree().call_deferred("change_scene_to_file","res://Cenas/tela_inicial.tscn")
