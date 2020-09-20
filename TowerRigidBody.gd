extends RigidBody2D

signal block_ready(res)
var state = 0

enum type{BASE,LIFE}
var block_type = type.BASE

var life_sym_tex = preload("res://icon.png") # Life symbol sprite
var symbols_tex = [life_sym_tex]

func _ready():
	if block_type == type.LIFE:
		$Symbol.set_texture(life_sym_tex)
		$Symbol.show()
	else:
		$Symbol.hide()

func _process(delta):
	if state == 1:
		if abs(angular_velocity) < 0.1:
			print("Stabilized")
			mode = RigidBody2D.MODE_STATIC
			self.set_collision_layer_bit(1, false)
			self.set_collision_layer_bit(0, true)
			state = 2
			emit_signal("block_ready", 0)
		else:
			print("Waiting")

func _on_body_entered(body):
	$Timer.start()

func _on_Timer_timeout():
	state = 1
	print("Finished")

func _on_screen_exited():
	print("Erased!")
	if state == 1 or state == 0: # Falling cases
		emit_signal("block_ready", 1)
	else:
		emit_signal("block_ready", 2)
	queue_free()
