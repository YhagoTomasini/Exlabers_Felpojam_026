extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.criar_aud(SoundEffect.TIPO_DE_SOM.TEMA2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
