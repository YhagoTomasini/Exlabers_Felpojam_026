extends Control

@export var fundo: TextureRect
@export var elementos: Control

@export var scroll_container: ScrollContainer
@export var text_node: RichTextLabel
@export var velo: float = 1.0
@export var pause: Control

var acabou: bool = false
var scroll_shader: ShaderMaterial
var fundo_scroll: float = 0.0


func _ready() -> void:
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
	if Input.is_action_pressed("ui_up"):
		velo = 6.0
	else:
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
