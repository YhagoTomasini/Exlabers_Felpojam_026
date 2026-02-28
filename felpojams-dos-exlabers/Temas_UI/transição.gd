extends CanvasLayer

@export var anim_duracao : float = 1.0
@export var anim : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func anim_out():
	visible = true
	anim.speed_scale = anim_duracao
	anim.play("transição_out")
	
	await anim.animation_finished
	
	visible = false
	
func anim_in():
	visible = true
	anim.speed_scale = anim_duracao
	anim.play("transição_in")
	
	await anim.animation_finished
	
	visible = false
