extends Node2D

@export var anim_duracao : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.vol_som(1, SoundEffect.TIPO_DE_SOM.TEMA2)
	
	#transicao.visible = false
	#animacao.speed_scale = anim_duracao
	#animacao.play("transição_out")
	#await animacao.animation_finished
	#transicao.visible = false
	
#func fim_lvl():
	#animacao.play("transição_out")
	#await animacao.animation_finished
	
