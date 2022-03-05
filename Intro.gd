extends Control

const _duration = 1.0
const _delay0 = 0.5
const _delay1 = 3.0
const _delay2 = 0.8

onready var _back:    = $Back
onready var _texture: = $Texture
onready var _fore:    = $Fore
onready var _tween:   = $Tween
onready var _timer:   = $Timer
onready var _audio:   = $Audio

func _ready() -> void:
	assert(_tween.connect("tween_all_completed", self, "_done") == OK)
	_tween.interpolate_property(_back, "color", Color8(59, 67, 82, 255), Color.black, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property(_texture, "rect_rotation", 0, 180, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property(_texture, "rect_scale", Vector2.ONE, Vector2.ONE * 3, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property(_fore, "color", Color(0, 0, 0, 0), Color.black, _duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, _delay1)
	_tween.start()
	_timer.start(_delay2)
	yield(_timer, "timeout")
	_audio.play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.pressed:
		_done()

func _unhandled_input(_event: InputEvent) -> void:
	_done()

func _done() -> void:
	get_tree().set_input_as_handled()
	queue_free()
