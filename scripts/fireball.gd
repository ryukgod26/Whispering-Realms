extends Area3D

var direction: Vector2
const SPEED :=  5.0

func _process(delta: float) -> void:
	position += Vector3(direction.x,0,direction.y) * SPEED * delta


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hit"):
		body.hit()
		queue_free()
