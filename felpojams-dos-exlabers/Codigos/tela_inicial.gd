extends Control

@onready var parallax = $ParallaxBG
@onready var botao_jogar: Button = $CanvasLayer/VBoxContainer/Jogar

@export var menuControles : Control
@export var configs : Control

var usando_teclado = false

var intensidade = 30.0
var suavidade = 5.0
var alvo = Vector2.ZERO

func _ready():
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.TEMA2)
	
	Transição.anim_out()
	
	#botao_jogar.grab_focus()
	
func _input(event):
	# 🎮 detecta teclado / controle
	if event.is_action_pressed("ui_up") \
	or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_left") \
	or event.is_action_pressed("ui_right"):

		if not usando_teclado:
			usando_teclado = true

			# se ninguém estiver focado, foca o primeiro botão
		if not get_viewport().gui_get_focus_owner():
			botao_jogar.grab_focus()


	# 🖱 detecta movimento do mouse
	if event is InputEventMouseMotion:
		if usando_teclado:
			usando_teclado = false

			var foco = get_viewport().gui_get_focus_owner()
			if foco:
				foco.release_focus()

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport_rect().size
	
	var offset = (mouse_pos - screen_size / 2.0) / (screen_size / 2.0)
	alvo = offset * intensidade
	parallax.scroll_offset = parallax.scroll_offset.lerp(alvo, delta * suavidade)

func _on_jogar_pressed() -> void:
	Globals.reset_de_tinta()
	Globals.saveTanqueCena()
	
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.CARIMBO)
	
	#transição
	Transição.anim_in()
	await Transição.anim.animation_finished
	#mudança de cena
	get_tree().change_scene_to_file("res://Cenas/cutscene.tscn")
	

func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/tela_creditos.tscn")
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.CARIMBO)

func _on_sair_pressed() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.CARIMBO)
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_contorles_pressed() -> void:
	menuControles.ativar()


func _on_configs_pressed() -> void:
	configs.visible = true
	configs.grabFocus()
