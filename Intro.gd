extends Control

@onready var _back: ColorRect = $Back
@onready var _logo: TextureRect = $Texture
@onready var _godot: TextureRect = $Godot
@onready var _fore: ColorRect = $Fore
@onready var _audio: AudioStreamPlayer = $Audio

const DURATION := 1.0
const DELAY_0 := 0.5
const DELAY_1 := 1.5
const DELAY_2 := 0.8

var _tween: Tween
var _tween_godot: Tween

func _ready() -> void:
	var target = _godot.global_position.x
	_godot.global_position.x = -DisplayServer.window_get_size().x
	_tween_godot = create_tween()
	_tween_godot.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	_tween_godot.tween_property(_godot, "global_position:x", target, DURATION)
	_tween = create_tween()
	_tween.tween_interval(DELAY_0)
	_tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	_tween.tween_property(_back, "color", Color.BLACK, DURATION)
	_tween.parallel().tween_property(_logo, "rotation", PI, DURATION)
	_tween.parallel().tween_property(_logo, "scale", Vector2.ONE * 3, DURATION)
	_tween.chain().tween_property(_fore, "color", Color.BLACK, DURATION).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(DELAY_1)
	_tween.tween_callback(_done)
	await get_tree().create_timer(DELAY_2).timeout
	_audio.play()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventScreenTouch or event is InputEventKey:
		_done()
	get_viewport().set_input_as_handled()

func _done() -> void:
	_tween_godot.kill()
	_tween.kill()
	queue_free()
