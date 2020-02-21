extends RigidBody2D

export var speed = 580
onready var Explosion = load("res://Scenes/Explosion.tscn")
onready var Player = get_node("/root/Game/Player")

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

# warning-ignore:unused_argument
func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		var explosion = Explosion. instance()
		explosion.position = position
		explosion.get_node("Sprite").playing = true
		get_node("/root/Game/Explosions").add_child(explosion)
		if c.get_parent().name == "Meteor":
			Player.change_score(c.score)
		queue_free()
		
	if position.y < -10:
		queue_free()

func _integrate_forces(state):
	state.set_linear_velocity(Vector2(0,-speed))
	state.set_angular_velocity(0)

