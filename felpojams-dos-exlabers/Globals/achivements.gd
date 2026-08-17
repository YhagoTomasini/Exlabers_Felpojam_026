extends Control

@export var icon : TextureRect
@export var nome : RichTextLabel
@export var anim : AnimationPlayer


var conquistas := {
	1: {
		"icon": preload("res://Imagens/carimbos/amarelo.png"),
		"texto": "[tremor][b]SEGUNDO DEGRAU[/b][/tremor] \n Completar a primeira fase."
	},
	2: {
		"icon": preload("res://Imagens/carimbos/magenta2.png"),
		"texto": "[tremor][b]TERCEIRO DEGRAU[/b][/tremor] \n Completar a segunda fase."
	},
	3: {
		"icon": preload("res://Imagens/carimbos/azul.png"),
		"texto": "[tremor][b]QUARTO DEGRAU[/b][/tremor] \n Completarar a terceira fase."
	},
	4: {
		"icon": preload("res://Imagens/carimbos/azul.png"),
		"texto": "[tremor][b]O FINAL[/b][/tremor] \n Finalizar o jogo."
	},
	5: {
		"icon": preload("res://Imagens/creditos/adesivo_felps.png"),
		"texto": "[tremor][b]VUGNAES SREO[/b][/tremor] \n Achar todos os Felps."
	}
}

func _ready() -> void:
	Globals.carregar_save()

func _liberar_conquista(id : int):
	
	if !Globals.dados.conquista.get(id, false):
		Globals.dados.conquista[id] = true
	
	var conquista = conquistas[id]
	
	icon.texture = conquista["icon"]
	nome.text = conquista["texto"]
	
	anim.play("new_animation")

func display(id : int):
	var conquista = conquistas[id]
	
	icon.texture = conquista["icon"]
	nome.text = conquista["texto"]
	
	anim.play("telaInicial_conq_anim")

func reset_anim():
	anim.play("RESET")
