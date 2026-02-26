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
	corFundo.color = Color(0.58, 0.0, 0.188, 0.486)

func despausa():
	AudioManager.pitch_tema(true, SoundEffect.TIPO_DE_SOM.TEMA2)
	get_tree().paused = false
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	visible = false
	reset.noReset = false
	reset.tavaPause = false
	parado = false
	
func pausar():
	if !parado:
		AudioManager.pitch_tema(false, SoundEffect.TIPO_DE_SOM.TEMA2)
		
		visible = true
		get_tree().paused = true
		grabFocus()
		await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
		reset.tavaPause = true
		#reset.noReset = true
		parado = true

func grabFocus():
	voltarB.grab_focus()
	await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	naConfig = false
	noReset = false
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		if reset.visible:
			return
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
	parado = false
	reset.grabFocus()
	

func _on_configrações_button_down() -> void:
	visible = false
	configs.visible = true
	naConfig = true
	configs.grabFocus()


func _on_voltar_pressed() -> void:
	despausa()
