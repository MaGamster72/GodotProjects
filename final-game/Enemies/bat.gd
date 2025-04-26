extends Area2D

@export var path: Path2D  # Assign the Path2D in the editor
@export var speed: float = 100.0  # Movement speed
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var path_curve: Curve2D
var current_distance: float = 0.0
var is_attacking: bool = false

func _ready():
	if path:
		path_curve = path.curve

func _process(delta):
	# Move along the path
	current_distance += speed * delta
	var total_length = path_curve.get_baked_length()
	if current_distance >= total_length - 2:
		game_over()
	else:
		global_position = path_curve.sample_baked(current_distance)


func _on_area_entered(area):
	if area.is_in_group("bullets"):  # Make sure bullets are in a "bullets" group
		die()

func die():
	queue_free()  # Destroy the enemy

func game_over():
	get_tree().change_scene_to_file("res://Title.tscn")
