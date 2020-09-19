extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == 2:
		if angular_velocity < 0.1 and linear_velocity < Vector2(0.1,0.1):
			print("Stabilized")
			state = 3
		else:
			print("Waiting")


func _on_Button_pressed():
	print("Pressed")
	var joint = get_node("../PinJoint2D2")
	var placeholder = get_node("../Placeholder")
	joint.node_b = placeholder.get_path()
	#joint.queue_free()

func _on_TowerBlock_body_entered(body):
	$Timer.start()


func _on_Timer_timeout():
	state = 2
	print("Finished")
