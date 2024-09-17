extends Control

@onready var _back: ColorRect = $Back
@onready var _texture: TextureRect = $Texture
@onready var _fore: ColorRect = $Fore
@onready var _audio: AudioStreamPlayer = $Audio

const _duration = 1.0
const _delay_0 = 0.5
const _delay_1 = 1.5
const _delay_2 = 0.8
var _tween: Tween

func _ready() -> void:
	_tween = create_tween()
	_tween.tween_interval(_delay_0)
	_tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	_tween.tween_property(_back, "color", Color.BLACK, _duration)
	_tween.parallel().tween_property(_texture, "rotation", PI, _duration)
	_tween.parallel().tween_property(_texture, "scale", Vector2.ONE * 3, _duration)
	_tween.chain().tween_property(_fore, "color", Color.BLACK, _duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(_delay_1)
	_tween.tween_callback(_done)
	await get_tree().create_timer(_delay_2).timeout
	_audio.play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch or event is InputEventKey:
		_done()
	get_viewport().set_input_as_handled()

func _done() -> void:
	_tween.kill()
	queue_free()
