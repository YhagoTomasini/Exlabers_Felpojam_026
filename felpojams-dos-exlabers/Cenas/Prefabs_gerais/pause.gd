extends Control

@onready var voltarB : Button = $VBoxContainer/Voltar
@onready var corFundo :ColorRect = $ColorRect
@export var configs : Control
@export var reset : Control

var parado : bool
var naConfig : bool
var noReset : bool

func _ready() -> void:
	visible = false
	parado = false
	naConfig = false
	noReset = false
	corFundo.color = Color(1.0, 1.0, 1.0, 0.25)

func despausa():
	get_tree().paused = false
	visible = false
	reset.noReset = false
	
func pausar():
	if !parado:
		visible = true
		get_tree().paused = true
		grabFocus()
		reset.tavaPause = true
		reset.noReset = true

func grabFocus():
	voltarB.grab_focus()
	naConfig = false
	noReset = false
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		if !parado:
			if !naConfig or !noReset:
				pausar()
		else:
			if !naConfig or !noReset:
				despausa()

func _on_menu_button_down() -> void:
	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/tela_inicial.tscn")

func _on_reiniciar_button_down() -> void:
	visible = false
	reset.visible = true
	noReset = true
	reset.grabFocus()
	

func _on_configrações_button_down() -> void:
	visible = false
	configs.visible = true
	naConfig = true
	configs.grabFocus()


func _on_voltar_pressed() -> void:
	despausa()
