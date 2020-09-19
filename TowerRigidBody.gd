extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("Pressed")
	var joint = get_node("../PinJoint2D2")
	var placeholder = get_node("../Placeholder")
	joint.node_b = placeholder.get_path()
