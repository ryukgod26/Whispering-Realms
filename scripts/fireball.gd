extends Area3D

var direction: Vector2
const SPEED :=  5.0

func _ready() -> void:
	scale = Vector3(0.1,0.1,0.1)

func _process(delta: float) -> void:
	position += Vector3(direction.x,0,direction.y) * SPEED * delta


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hit"):
		body.hit()
		queue_free()

func setup(size: float):
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector3.ONE * size,0.3)
