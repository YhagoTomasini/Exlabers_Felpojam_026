extends Resource
class_name SaveInfo

@export var finalizou : bool

#SPEEDRUN MODE
@export var speedrun_mode : bool

@export var tempo_segs : int
@export var high_tempo : int

#CONQUISTAS
@export var telaConquistaOn : bool

@export var conquista := {
	0: false, #passar a primeira fase
	1: false, #passar a segunda fase
	2: false, #passar a terceira fase
	3: false, #finalizar o jogo
	4: false, #achar todos is felpses
	5: false, #achar o felps anao
	6: false,
	}

#FELPSES 9
@export var felps_contados := [
	false, false, false, false, false, false, false, false, false
	]
@export var totalFelps : int

@export var assassinos_contados := [
	false, false, false
]
@export var totalAssassinos : int
