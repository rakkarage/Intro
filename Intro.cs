using Godot;
using static Godot.Color;
using static Godot.Tween;
public class Intro : Control
{
	private AudioStreamPlayer _player;
	private readonly float _delay = .333f;
	private readonly float _duration = 1f;
	public override void _Ready()
	{
		_player = GetNode<AudioStreamPlayer>("Audio");
		var tween = new Tween();
		tween.Connect("tween_all_completed", this, "OnTweenComplete");
		AddChild(tween);
		tween.InterpolateProperty(GetNode("Back"), "color",
			Color8(59, 67, 82, 255), ColorN("Black"),
			_duration, TransitionType.Bounce, EaseType.Out, _delay);
		tween.InterpolateProperty(GetNode("Fore"), "color",
			Color8(0, 0, 0, 0), Color8(0, 0, 0, 255),
			_duration, TransitionType.Linear, EaseType.InOut, 3f);
		var textureRect = GetNode("Center/Texture");
		tween.InterpolateProperty(textureRect, "rect_rotation", 0, 180,
			_duration, TransitionType.Bounce, EaseType.Out, _delay);
		tween.InterpolateProperty(textureRect, "rect_scale", Vector2.One, new Vector2(4, 4),
			_duration, TransitionType.Bounce, EaseType.Out, _delay);
		tween.Start();
		var timer = new Timer { OneShot = true };
		timer.Connect("timeout", this, "OnTimeout");
		AddChild(timer);
		timer.Start(.666f);
	}
	public void OnTimeout() => _player.Play();
	public void OnTweenComplete() => QueueFree();
}
