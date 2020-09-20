extends RigidBody2D

signal block_ready(res)

func _ready():
	pass

func _on_VisibilityNotifier2D_screen_exited():
	self.hide()
	emit_signal("block_ready", 2)
	queue_free()
