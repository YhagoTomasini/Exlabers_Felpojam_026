extends RichTextEffect
class_name TremorLento

var bbcode = "tremor"

func _process_custom_fx(char_fx):
	var intensidade = 3.0
	var tempo = int(Time.get_ticks_msec() / 800.0)

	char_fx.offset.y += intensidade * (1 if ((tempo + char_fx.relative_index) % 2 == 0) else -1)

	return true
