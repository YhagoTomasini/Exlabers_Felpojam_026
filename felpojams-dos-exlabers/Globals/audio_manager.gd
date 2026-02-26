extends Node2D

var registroSons : Dictionary = {}

var sonsAtivos : Dictionary = {}

var pitchOriginal : Dictionary = {}

@export var sons : Array[SoundEffect]

func _ready() -> void:
	for sons : SoundEffect in sons:
		registroSons[sons.tipo] = sons

func criar_aud_localizado(local : Vector2, tipo : SoundEffect.TIPO_DE_SOM):
	if registroSons.has(tipo):
		var som : SoundEffect = registroSons[tipo]
		if som.tem_limite():
			som.contar_aud(1)
			var novo_aud : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			add_child(novo_aud)
			
			novo_aud.bus = som.bus
			novo_aud.position = local
			novo_aud.stream = som.som
			novo_aud.volume_db = som.volume
			novo_aud.pitch_scale = som.pitch
			novo_aud.pitch_scale += randf_range(-som.pitch_rand, som.pitch_rand)
			
			novo_aud.finished.connect(som.quando_som_acabar)
			novo_aud.finished.connect(novo_aud.queue_free)
			
			novo_aud.play()
	else:
		push_error("n foi o audio", tipo)

func criar_aud(tipo : SoundEffect.TIPO_DE_SOM):
	if registroSons.has(tipo):
		var som : SoundEffect = registroSons[tipo]
		if som.tem_limite():
			som.contar_aud(1)
			var novo_aud : AudioStreamPlayer = AudioStreamPlayer.new()
			add_child(novo_aud)
			
			novo_aud.bus = som.bus
			novo_aud.stream = som.som
			novo_aud.volume_db = som.volume
			novo_aud.pitch_scale = som.pitch
			novo_aud.pitch_scale += randf_range(-som.pitch_rand, som.pitch_rand)
			
			novo_aud.finished.connect(som.quando_som_acabar)
			novo_aud.finished.connect(novo_aud.queue_free)
			
			novo_aud.play()
			
			sonsAtivos[tipo] = novo_aud
			pitchOriginal[tipo] = novo_aud.pitch_scale
	else:
		push_error("n foi o audio", tipo)

func destruir_novo_aud(tipo : SoundEffect.TIPO_DE_SOM):
	if sonsAtivos.has(tipo):
		var som = sonsAtivos[tipo]
		var tween = create_tween()
		var controleLimite : SoundEffect = registroSons[tipo]
		
		tween.tween_property(som, "volume_db", -40, 0.3)
		tween.tween_callback(func():
			som.stop()
			controleLimite.contar_aud(-1)
			som.queue_free()
		)
		sonsAtivos.erase(tipo)
		
func pitch_tema(normal : bool, tipo : SoundEffect.TIPO_DE_SOM):
	if sonsAtivos.has(tipo) and pitchOriginal.has(tipo):
		var temaAtivo = sonsAtivos[tipo]
		var pitch_base = pitchOriginal[tipo]
		var tween = create_tween()
		
		if normal:
			tween.tween_property(temaAtivo, "pitch_scale", pitch_base, 0.5)
		else:
			tween.tween_property(temaAtivo, "pitch_scale", pitch_base / 2.0, 0.5)
			
