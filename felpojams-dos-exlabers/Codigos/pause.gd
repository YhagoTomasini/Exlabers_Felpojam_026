extends Control

@onready var voltarB : Button = $VBoxContainer/Voltar
@onready var corFundo :ColorRect = $ColorRect

var parado : bool

func _ready() -> void:
	visible = false
	parado = false
	corFundo.color = Color(1.0, 1.0, 1.0, 0.25)

func despausa():
	get_tree().paused = false
	visible = false
	
func pausar():
	if !parado:
		visible = true
		get_tree().paused = true
		voltarB.grab_focus()
		
func _unhandled_input(event: InputEvent) -> void:
	if !parado:
		if event.is_action_pressed("ui_pause"):
			pausar()
	else:
		if event.is_action_pressed("ui_pause"):
			despausa()

func _on_menu_button_down() -> void:
	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/tela_inicial.tscn")

func _on_reiniciar_button_down() -> void:
	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")

func _on_configrações_button_down() -> void:
	pass # Replace with function body.

func _on_voltar_button_down() -> void:
	despausa()
