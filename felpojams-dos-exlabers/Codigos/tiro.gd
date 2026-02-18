extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim

var velocidade_do_tiro := 360
var direcao := 1 

func _process(delta: float) -> void:
	position.x += velocidade_do_tiro * direcao * delta
	

func qual_direcao(dir):
	direcao = dir
	if dir < 0:
		$anim.flip_h = true
	else:
		$anim.flip_h = false


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
		print("Ir no tiro e habilitar a morte")
		#body.player_morreu()
