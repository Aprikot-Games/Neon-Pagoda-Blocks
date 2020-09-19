extends RigidBody2D

signal block_ready
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 1:
		if angular_velocity < 0.1 and linear_velocity < Vector2(0.1,0.1):
			print("Stabilized")
			mode = RigidBody2D.MODE_STATIC
		else:
			print("Waiting")
			self.queue_free()
		state = 2
		emit_signal("block_ready")

func _on_TowerBlock_body_entered(body):
	$Timer.start()

func _on_Timer_timeout():
	state = 1
	print("Finished")
