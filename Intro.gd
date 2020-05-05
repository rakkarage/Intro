extends Control

const _duration = 1.0
const _delay0 = 0.333
const _delay1 = 3.0
const _delay2 = 0.666

func _ready():
	$Tween.interpolate_property($Back, "color", Color8(59, 67, 82, 255), Color.black, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	$Tween.interpolate_property($Texture, "rect_rotation", 0, 180, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	$Tween.interpolate_property($Texture, "rect_scale", Vector2.ONE, Vector2.ONE * 4, _duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, _delay0)
	$Tween.interpolate_property($Fore, "color", Color(0, 0, 0, 0), Color.black, _duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, _delay1)
	$Tween.start()
	Utility.ok($Tween.connect("tween_all_completed", self, "done"))
	$Timer.start(_delay2)
	Utility.ok($Timer.connect("timeout", self, "_on_Timer_timeout"))

func _on_Timer_timeout(): $Audio.play()

func _input(event): if event.is_pressed(): done()

func _unhandled_input(_event): done()

func done(): queue_free()
