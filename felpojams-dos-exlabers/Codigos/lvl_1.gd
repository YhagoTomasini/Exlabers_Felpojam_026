extends Node2D

@onready var transicao: CanvasLayer = $CanvasLayer/Transição
@onready var animacao = $CanvasLayer/Transição/ColorRect/Animation

@export var anim_duracao : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.TEMA2)
	
	animacao.visible = false
	#animacao.speed_scale = anim_duracao
	#animacao.play("transição_out")
	#await animacao.animation_finished
	#transicao.visible = false
