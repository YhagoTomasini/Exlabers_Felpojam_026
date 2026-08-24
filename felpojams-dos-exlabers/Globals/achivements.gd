extends Control

@export var icon : TextureRect
@export var nome : RichTextLabel
@export var anim : AnimationPlayer


var conquistas := {
	0: {
		"icon": Globals.amarelo,
		"texto": "[tremor][b]SEGUNDO DEGRAU[/b][/tremor]",
		"descricao": "Completar a primeira fase."
	},
	1: {
		"icon": Globals.magenta,
		"texto": "[tremor][b]TERCEIRO DEGRAU[/b][/tremor]",
		"descricao": "Completar a segunda fase."
	},
	2: {
		"icon": Globals.ciano,
		"texto": "[tremor][b]QUARTO DEGRAU[/b][/tremor]",
		"descricao": "Completarar a terceira fase."
	},
	3: {
		"icon": Globals.preto,
		"texto": "[tremor][b]O FINAL[/b][/tremor]",
		"descricao": "Finalizar o jogo."
	},
	4: {
		"icon": Globals.felpsPic,
		"texto": "[tremor][b]VUGNAES SREO[/b][/tremor]",
		"descricao": "Achar todos os Felps."
	}
}

func _ready() -> void:
	Globals.carregar_save()

func _liberar_conquista(id : int):
	
	if !Globals.dados.conquista.get(id, false):
		Globals.dados.conquista[id] = true
	
		var conquista = conquistas[id]
		
		icon.texture = conquista["icon"]
		nome.text = conquista["texto"] + "\n\n" + conquista["descricao"]
		
		anim.play("new_animation")

func display(id : int):
	var conquista = conquistas[id]
	
	if Globals.dados.conquista.get(id, false):
		icon.texture = conquista["icon"]
		nome.text = conquista["texto"] + "\n\n" + conquista["descricao"]
	
	else:
		icon.texture = Globals.preto
		nome.text = "[tremor][b]?????[/b][/tremor]" + "\n\n" + conquista["descricao"]
	
	anim.play("telaInicial_conq_anim")

func reset_anim():
	anim.play("RESET")
