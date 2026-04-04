extends Control

@export var icon : TextureRect
@export var nome : RichTextLabel
@export var anim : AnimationPlayer

@onready var icon1 = preload("res://Imagens/carimbos/amarelo.png")
@onready var icon2 = preload("res://Imagens/carimbos/magenta2.png")
@onready var icon3 = preload("res://Imagens/carimbos/azul.png")
#@onready var icon1 = preload()
#@onready var icon1 = preload()

func conquista(id : int):
	match  id:
		1:
			if Globals.dados.conquista1 == false:
				Globals.dados.conquista1 = true
				
				icon.texture = icon1
				nome.text = "[tremor][b]SEGUNDO DEGRAU[/b][/tremor] \n Completar a primeira fase."
				
				anim.play("new_animation")
		2:
			if Globals.dados.conquista2 == false:
				Globals.dados.conquista2 = true
				icon.texture = icon2
				nome.text = "[tremor][b]TERCEIRO DEGRAU[/b][/tremor] \n Completar a segunda fase."
				
				anim.play("new_animation")
		3:
			if Globals.dados.conquista3 == false:
				Globals.dados.conquista3 = true
				icon.texture = icon3
				nome.text = "[tremor][b]QUARTO DEGRAU[/b][/tremor] \n Completar a terceira fase."
				
				anim.play("new_animation")
		
		4:
			if Globals.dados.conquista4 == false:
				Globals.dados.conquista4 = true
				icon.texture = icon1
				nome.text = "[tremor][b]O FINAL[/b][/tremor] \n Completar a segunda fase."
				
				anim.play("new_animation")
