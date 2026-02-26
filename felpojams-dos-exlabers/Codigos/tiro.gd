extends CharacterBody2D


@onready var sprite: Sprite2D = $sprite

var velocidade_do_tiro := 540
var direcao := 1 

func _process(delta: float) -> void:
	position.x += velocidade_do_tiro * direcao * delta
	

func qual_direcao(dir):
	direcao = dir
	if dir < 0:
		$sprite.flip_v = true
	else:
		$sprite.flip_v = false


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
		print("Ir no tiro e habilitar a morte")
		body.player_morreu()
