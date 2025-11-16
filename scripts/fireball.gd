extends Area3D

var direction: Vector2
const SPEED :=  10.0

func _ready() -> void:
	scale = Vector3(0.1,0.1,0.1)

func _process(delta: float) -> void:
	position += Vector3(direction.x,0,direction.y) * SPEED * delta


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("hit"):
		body.hit()
		queue_free()

func setup(size: float):
	$FireballMesh.rotation.y = -(direction.angle() + PI/2) +PI
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector3.ONE * size,0.3)


func _on_destroy_timer_timeout() -> void:
	queue_free()
