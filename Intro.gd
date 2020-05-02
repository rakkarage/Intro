extends Control

const duration = 1.0
const delay0 = 0.333
const delay1 = 3.0
const delay2 = 0.666

func _ready():
	$Tween.interpolate_property($Back, "color", Color8(59, 67, 82, 255), Color.black, duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, delay0)
	$Tween.interpolate_property($Texture, "rect_rotation", 0, 180, duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, delay0)
	$Tween.interpolate_property($Texture, "rect_scale", Vector2.ONE, Vector2.ONE * 4, duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT, delay0)
	$Tween.interpolate_property($Fore, "color", Color(0, 0, 0, 0), Color.black, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, delay1)
	$Tween.start()
	Utility.ok($Tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed"))
	$Timer.start(delay2)
	Utility.ok($Timer.connect("timeout", self, "_on_Timer_timeout"))

func _on_Timer_timeout():
	$Audio.play()

func _input(event):
	if event.is_pressed():
		queue_free()

func _unhandled_input(_event):
	queue_free()

func _on_Tween_tween_all_completed():
	queue_free()
