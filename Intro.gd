extends Control

const _duration = 1.0
const _delay0 = 0.333
const _delay1 = 3.0
const _delay2 = 0.666

onready var _tween = $Tween
onready var _timer = $Timer

func _ready() -> void:
	_tween.interpolate_property($Back, "color", Color8(59, 67, 82, 255), Color.black, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property($Texture, "rect_rotation", 0, 180, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property($Texture, "rect_scale", Vector2.ONE, Vector2.ONE * 4, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	_tween.interpolate_property($Fore, "color", Color(0, 0, 0, 0), Color.black, _duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, _delay1)
	_tween.start()
	Utility.ok(_tween.connect("tween_all_completed", self, "_done"))
	_timer.start(_delay2)
	yield(_timer, "timeout")
	$Audio.play()

func _input(event) -> void: if event.is_pressed(): _done()

func _unhandled_input(_event) -> void: _done()

func _done() -> void:
	get_tree().set_input_as_handled()
	queue_free()
