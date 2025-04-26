extends Node2D

@export var enemy_scene: PackedScene  # Drag the Enemy.tscn here
@export var level_scene: NodePath  # Drag the path in your level scene here
@export var spawn_rate: float = 2.0  # Time in seconds between each spawn
@export var enemy_per_round = 2.0  
var round = 1
var spawn_timer: float = 0.0
var path_nodes: Array = []
var enemies_spawned = 0
func _ready():
	var level = get_node(level_scene)
	# Find all Path2D nodes in the level scene
	path_nodes = level.get_children().filter(func(n): return n is Path2D)


func _process(delta):
	if not $Music.playing:
		$Music.play()
	spawn_timer -= delta
	if spawn_timer <= 0.0 and enemies_spawned < enemy_per_round:
		spawn_enemy()
		spawn_timer = spawn_rate
	if get_tree().get_nodes_in_group("Enemy").size() == 0  and enemies_spawned == enemy_per_round:
		enemies_spawned = 0
		new_level()
	

func spawn_enemy():
	if enemy_scene and path_nodes.size() > 0:
		# Instantiate the enemy
		var enemy = enemy_scene.instantiate()

		# Pick a random path from the list of Path2D nodes
		var random_path = path_nodes[randi() % path_nodes.size()]
		enemy.path = random_path  # Assign the path to the enemy

		# Optionally, you can modify the enemy's position here before adding it
		enemy.global_position = random_path.global_position  # Place at the start of the path

		# Add the enemy to the scene
		add_child(enemy)
		enemies_spawned += 1  # Track the number of enemies spawned

func new_level():
	print("yeet")
	round += 1
	$HUD.update_round(round)
	enemies_spawned = 0  # Reset the counter for the new round
	enemy_per_round += 2 * round
	spawn_rate -= .01  # Increase the number of enemies by 2 after each round
	spawn_timer = spawn_rate  # Reset the spawn timer
