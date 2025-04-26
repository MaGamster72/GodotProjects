extends Area2D

@export var rotation_speed : float = 5.0
@export var fire_rate = 0.25
var can_shoot = true

func _process(delta):
	# Get the position of the mouse in world 
	$GunCooldown.wait_time = fire_rate
	var mouse_pos = get_viewport().get_mouse_position()
	get_input()
	# Calculate the direction to the mouse
	var direction = mouse_pos - global_position
	var angle_to_mouse = direction.angle()
	
	# Rotate the turret smoothly towards the mouse
	rotation = lerp_angle(rotation, angle_to_mouse, rotation_speed * delta)


func get_input():
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()


func shoot():
	can_shoot = false
	$GunCooldown.start()
	if not $Lazer.playing:
		$Lazer.play()
	var bullet_1_scene = preload("res://Bullets/bullet_main.tscn")  
	var b = bullet_1_scene.instantiate()  # instantiate the scene
	get_tree().root.add_child(b)
	b.start($Muzzle.global_transform)


func _on_gun_cooldown_timeout():
	can_shoot = true
