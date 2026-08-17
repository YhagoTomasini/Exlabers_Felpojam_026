extends Resource
class_name SaveInfo

@export var finalizou : bool

#SPEEDRUN MODE
@export var speedrun_mode : bool

@export var tempo_segs : int
@export var high_tempo : int

#CONQUISTAS
@export var conquista := {
	0: false, 1: false, 2: false, 3: false, 4: false, 5: false, 6: false,
	}

#FELPSES 9
@export var felps_contados := [
	false, false, false, false, false, false, false, false, false
	]
@export var totalFelps : int
