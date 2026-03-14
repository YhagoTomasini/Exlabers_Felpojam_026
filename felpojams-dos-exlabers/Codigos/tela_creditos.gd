extends Control

@export var fundo: TextureRect
@export var elementos: Control

@export var scroll_container: ScrollContainer
@export var text_node: RichTextLabel
@export var velo: float = 1.0
@export var pause: Control

@export var prova : TextureRect

var acabou: bool = false
var scroll_shader: ShaderMaterial
var fundo_scroll: float = 0.0

var acelerando : bool

func _ready() -> void:
	Transição.anim_out()
	
	
	
	if !Globals.dados.finalizou:
		prova.visible = false
	else:
		AudioManager.destruir_todos_aud(SoundEffect.TIPO_DE_SOM.TEMA2)
		AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.TEMA1)
		
	
	acelerando = false
	acabou = false
	scroll_shader = fundo.material as ShaderMaterial
	
	if scroll_shader == null:
		push_error("O fundo precisa ter um ShaderMaterial com o parâmetro 'scroll_y'.")


func fim():
	acabou = true
	pause.pausar()
	print("fim")


func _process(delta: float) -> void:
	if acabou:
		return
	
	# Controle de velocidade
	if Input.is_action_pressed("_up"):
		if !acelerando:
			AudioManager.pitch_tema(3, SoundEffect.TIPO_DE_SOM.TEMA1)
			AudioManager.pitch_tema(3, SoundEffect.TIPO_DE_SOM.TEMA2)
			acelerando = true
		velo = 6.0
	else:
		if acelerando:
			AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA1)
			AudioManager.pitch_tema(1, SoundEffect.TIPO_DE_SOM.TEMA2)
			acelerando = false
		velo = 1.0
	
	if scroll_container.scroll_vertical <= text_node.size.y + 100:
		
		# Move créditos
		scroll_container.scroll_vertical += velo
		
		var tex_height = fundo.texture.get_height()
		
		# Alvo correto em UV (baseado na altura real da textura)
		var alvo = float(scroll_container.scroll_vertical) / float(tex_height)
		
		# 🔥 Desaceleração suave do fundo
		fundo_scroll = lerp(fundo_scroll, alvo, 2.0 * delta)
		
		scroll_shader.set_shader_parameter("scroll_y", fundo_scroll)
		
		# 🔥 Elementos seguem a cortiça em pixels reais
		elementos.position.y = -scroll_container.scroll_vertical
		
	else:
		fim()
