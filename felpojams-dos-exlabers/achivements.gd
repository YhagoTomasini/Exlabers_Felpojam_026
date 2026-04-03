extends Control

@export var icon : TextureRect
@export var nome : RichTextLabel
@export var anim : AnimationPlayer

func conquista(id : int):
	match  id:
		1:
			if SaveInfo.conquista1 == false:
				icon.texture = load("res://Imagens/carimbos/amarelo.png")
				nome.text = "SEGUNDO DEGRAU \n Completar a primeira fase."
				
				anim.play()
		2:
			pass
		3:
			pass
