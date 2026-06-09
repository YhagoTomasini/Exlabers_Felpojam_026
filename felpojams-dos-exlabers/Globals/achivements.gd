extends Control

@export var icon : TextureRect
@export var nome : RichTextLabel
@export var anim : AnimationPlayer

@onready var icon1 = preload("res://Imagens/carimbos/amarelo.png")
@onready var icon2 = preload("res://Imagens/carimbos/magenta2.png")
@onready var icon3 = preload("res://Imagens/carimbos/azul.png")
#@onready var icon1 = preload()
@onready var icon5 = preload("res://Imagens/creditos/adesivo_felps.png")

func _ready() -> void:
	Globals.carregar_save()

func conquista(id : int):
	match  id:
		1:
			if !Globals.dados.conquista.get(0, false):
				Globals.dados.conquista[0] = true
				
				icon.texture = icon1
				nome.text = "[tremor][b]SEGUNDO DEGRAU[/b][/tremor] \n Completar a primeira fase."
				
				anim.play("new_animation")
		2:
			if !Globals.dados.conquista.get(1, false):
				Globals.dados.conquista[1] = true
				
				icon.texture = icon2
				nome.text = "[tremor][b]TERCEIRO DEGRAU[/b][/tremor] \n Completar a segunda fase."
				
				anim.play("new_animation")
		3:
			if !Globals.dados.conquista.get(2, false):
				Globals.dados.conquista[2] = true
				
				icon.texture = icon3
				nome.text = "[tremor][b]QUARTO DEGRAU[/b][/tremor] \n Completar a terceira fase."
				
				anim.play("new_animation")
		4:
			if !Globals.dados.conquista.get(3, false):
				Globals.dados.conquista[3] = true
				
				icon.texture = icon1
				nome.text = "[tremor][b]O FINAL[/b][/tremor] \n Finalizar o jogo."
				
				anim.play("new_animation")
		5:
			if !Globals.dados.conquista.get(4, false):
				Globals.dados.conquista[4] = true
				
				icon.texture = icon5
				nome.text = "[tremor][b]VUGNAES SREO[/b][/tremor] \n Achar todos os Felps."
				
				anim.play("new_animation")

func display(id : int):
	match  id:
		1:
			icon.texture = icon1
			nome.text = "[tremor][b]SEGUNDO DEGRAU[/b][/tremor] \n Completar a primeira fase."
				
			anim.play("telaInicial_conq_anim")
		2:
			icon.texture = icon2
			nome.text = "[tremor][b]TERCEIRO DEGRAU[/b][/tremor] \n Completar a segunda fase."
				
			anim.play("telaInicial_conq_anim")
		3:
			icon.texture = icon3
			nome.text = "[tremor][b]QUARTO DEGRAU[/b][/tremor] \n Completar a terceira fase."
				
			anim.play("telaInicial_conq_anim")
		4:
			icon.texture = icon1
			nome.text = "[tremor][b]O FINAL[/b][/tremor] \n Finalizar o jogo."
				
			anim.play("telaInicial_conq_anim")
		5:
			icon.texture = icon5
			nome.text = "[tremor][b]VUGNAES SREO[/b][/tremor] \n Achar todos os Felps."
				
			anim.play("telaInicial_conq_anim")

func reset_anim():
	anim.play("RESET")
