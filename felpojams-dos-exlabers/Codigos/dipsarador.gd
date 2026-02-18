extends StaticBody2D

const TIRO = preload("res://Prefabs/tiro.tscn")

@onready var marker: Marker2D = $marker
@onready var cd_tiro: Timer = $cd_tiro
@onready var detector: RayCast2D = $detector


@export var para_direita : bool = true


func _ready() -> void:
	if !para_direita:
		scale.x *= -1


func _process(_delta: float) -> void:
	if detector.is_colliding():
		if cd_tiro.is_stopped():
			cd_tiro.start()
#Se quiser que ele atire na hora q entrar na area
			#spawn_tiro()
	else:
		cd_tiro.stop()


func spawn_tiro():
	var novo_tiro = TIRO.instantiate()
	if para_direita:
		novo_tiro.qual_direcao(1)
	else:
		novo_tiro.qual_direcao(-1)
	add_sibling(novo_tiro)
	novo_tiro.global_position = marker.global_position


func _on_cd_tiro_timeout() -> void:
	spawn_tiro()
	print("atirou")
