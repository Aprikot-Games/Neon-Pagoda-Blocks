extends RigidBody2D
#class_name Pendulum

var pivot_point:Vector2
export (Vector2) var end_position: = Vector2()
var arm_length:float
var angle
var offset = Vector2(250, 150)

export (float) var gravity = 0.4 * 60
#export (float) var damping = 0.995 

var angular_velocity = 0.0
var angular_acceleration = 0.0

func _ready()->void:
	set_start_position(global_position, end_position)

func set_start_position(start_pos:Vector2, end_pos:Vector2):
	pivot_point = start_pos
	end_position = end_pos
	arm_length = Vector2.ZERO.distance_to(end_position-pivot_point)
	angle = Vector2.ZERO.angle_to(end_position-pivot_point) - deg2rad(-90)
	angular_velocity = 0.0
	angular_acceleration = 0.0

func process_velocity(delta:float)->void:
	angular_acceleration = ((-gravity*delta) / arm_length) *sin(angle)
	angular_velocity += angular_acceleration
	#angular_velocity *= damping
	angle += angular_velocity
	end_position = pivot_point + Vector2(arm_length*sin(angle), arm_length*cos(angle))

func add_angular_velocity(force:float)->void:
	angular_velocity += force

func _physics_process(delta)->void:
	process_velocity(delta)
	update()												#draw

func _draw()->void:
	#draw_line(Vector2.ZERO, end_position - pivot_point, Color.white, 1.0, false)
	#draw_circle(end_position - pivot_point + offset, 3.0, Color.red)
	position = end_position - pivot_point + offset
