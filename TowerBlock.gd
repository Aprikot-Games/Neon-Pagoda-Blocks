extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum TYPE {BASE,SLOW,FIXER,WIDE}
export var wide = false
export var next = 0
export var prev = 0
var pos = Vector2(10, PI/2)
export var hang = true
var c = 0
var debug = true

func dbg_print(x):
	if debug == true:
		print(x)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Oscillation for the block, speed should vary depending on the increment
func swing():
	var r = pos[0]
	var th = pos[1]
	var c_n = c / 60
	th = PI/2 + ((PI/4)*(sin(c_n)))
	var cart_pos = polar2cartesian(r, th)
	self.position.x = cart_pos[0]
	self.position.y = cart_pos[1]
	c += 1
	if c > 60:
		c = 0

func _process(delta):
	if delta >= 0.01667:
		if hang == true:
			swing()

func on_drop():
	dbg_print("Drop!")
