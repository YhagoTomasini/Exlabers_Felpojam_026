extends Control

@export var scroll_container: ScrollContainer
@export var fundo: TextureRect
@export var text_node: RichTextLabel
@export var velo: float = 1.0
@export var pause: Control

var acabou: bool = false
var scroll_shader: ShaderMaterial


func _ready() -> void:
	acabou = false
	
	# Pega o material do fundo
	scroll_shader = fundo.material as ShaderMaterial


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
	
	# Continua rolando
	if scroll_container.scroll_vertical <= text_node.size.y + 100:
		
		scroll_container.scroll_vertical += velo
		
		# Move o fundo via shader (valor pequeno para não ficar rápido demais)
		scroll_shader.set_shader_parameter(
			"scroll_y",
			scroll_container.scroll_vertical / 1500.0
		)
		
	else:
		fim()
