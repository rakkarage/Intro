extends Node

const _duration = 1.0
const _delay0 = 0.5
const _delay1 = 1.5
const _delay2 = 0.8

@onready var _back:    = $Back
@onready var _texture: = $Texture
@onready var _fore:    = $Fore
@onready var _audio:   = $Audio
var _tween: Tween

func _ready() -> void:
	_tween = create_tween()
	_tween.tween_interval(_delay0)
	_tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	_tween.tween_property(_back, "color", Color.BLACK, _duration)
	_tween.parallel().tween_property(_texture, "rotation", PI, _duration)
	_tween.parallel().tween_property(_texture, "scale", Vector2.ONE * 3, _duration)
	_tween.chain().tween_property(_fore, "color", Color.BLACK, _duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(_delay1)
	_tween.tween_callback(_done)
	var timer := get_tree().create_timer(_delay2)
	await timer.timeout
	_audio.play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.pressed:
		_done()

func _unhandled_key_input(_event: InputEvent) -> void:
	_done()

func _done() -> void:
	_tween.kill()
	get_viewport().set_input_as_handled()
	queue_free()
