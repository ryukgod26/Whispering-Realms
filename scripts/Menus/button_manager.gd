extends VBoxContainer

var rng = RandomNumberGenerator.new()

func start_breathing():
	for child in get_children():
		var scale_xy = rng.randf_range(0.7,0.9)
		var tween = create_tween()
		tween.parallel()
		#tween.tween_property(child,"scale:x",scale_xy,0.5)
		tween.tween_property(child,"scale:y",scale_xy,0.5)

func stop_breathing():
	for child in get_children():
		var scale_xy = rng.randf_range(1.0,1.1)
		var tween = create_tween()
		tween.parallel()
		#tween.tween_property(child,"scale:x",scale_xy,0.5)
		tween.tween_property(child,"scale:y",scale_xy,0.5)
