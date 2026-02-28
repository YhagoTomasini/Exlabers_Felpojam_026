extends Control

@onready var voltarB : Button = $VBoxContainer/Voltar
@onready var corFundo :ColorRect = $ColorRect
@export var configs : Control
@export var reset : Control

var parado : bool
var naConfig : bool
var noReset : bool

var usando_teclado : bool 

func _ready() -> void:
	visible = false
	parado = false
	naConfig = false
	noReset = false
	corFundo.color = Color(0.58, 0.0, 0.188, 0.486)
	
	usando_teclado = false

func despausa():
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)
	get_tree().paused = false
	#await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
	visible = false
	reset.noReset = false
	reset.tavaPause = false
	parado = false
	
func pausar():
	if !parado:
		AudioManager.pitch_tema(2, SoundEffect.TIPO_DE_SOM.TEMA1)
		AudioManager.pitch_tema(2, SoundEffect.TIPO_DE_SOM.TEMA2)
		
		visible = true
		get_tree().paused = true
		
		await get_tree().process_frame
		#voltarB.grab_focus()
		
		reset.tavaPause = true
		parado = true

func grabFocus():
	#voltarB.grab_focus()
	#await get_tree().create_timer(0.1).timeout #DEUS EXISE AQ
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

	# 🎮 detecta teclado / controle
	if visible:
		if event.is_action_pressed("ui_up") \
		or event.is_action_pressed("ui_down") \
		or event.is_action_pressed("ui_left") \
		or event.is_action_pressed("ui_right"):

			if not usando_teclado:
				usando_teclado = true

				# se ninguém estiver focado, foca o primeiro botão
			if not get_viewport().gui_get_focus_owner():
				voltarB.grab_focus()

		# 🖱 detecta movimento do mouse
		if event is InputEventMouseMotion:
			if usando_teclado:
				usando_teclado = false

				var foco = get_viewport().gui_get_focus_owner()
				if foco:
					foco.release_focus()

	
func _on_menu_pressed() -> void:
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)

	Globals.refil_de_tinta()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/tela_inicial.tscn")


func _on_reiniciar_pressed() -> void:
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
	AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)
	
	visible = false
	reset.visible = true
	noReset = true
	parado = false
	reset.grabFocus()


func _on_configurações_pressed() -> void:
	visible = false
	configs.visible = true
	naConfig = true
	configs.grabFocus()

func _on_voltar_pressed() -> void:
	despausa()
