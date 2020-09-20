extends RigidBody2D

signal block_ready(res)
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		if abs(angular_velocity) < 0.1:
			print("Stabilized")
			mode = RigidBody2D.MODE_STATIC
			self.set_collision_layer_bit(1, false)
			self.set_collision_layer_bit(0, true)
			state = 2
			emit_signal("block_ready", true)
		else:
			print("Waiting")

func _on_body_entered(body):
	$Timer.start()

func _on_Timer_timeout():
	state = 1
	print("Finished")

func _on_screen_exited():
	print("Erased!")
	emit_signal("block_ready", false)
	queue_free()
