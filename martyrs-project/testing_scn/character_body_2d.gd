extends CharacterBody2D

@export var per_velocity = 20
var x_pos = 0
var y_pos = 0

func _ready():
	x_pos = self.position.x
	y_pos = self.position.y
	

func _input(event):
	if event.is_action("walk_right"):
		x_pos += per_velocity
		self.position.x = x_pos

	if event.is_action("walk_left"):
		x_pos -= per_velocity
		self.position.x = x_pos        
	
	if event.is_action("walk_up"):
		y_pos -= per_velocity
		self.position.y = y_pos   

	if event.is_action("walk_down"):
		y_pos += per_velocity
		self.position.y = y_pos  
