extends Control

var press_nodes: Array = []

# Preload textures by tier
var tier_textures := [
	preload("res://Assets/Art/icon.svg"), # Tier 1
	preload("res://Assets/Art/icon.svg"), # Tier 2 (replace later)
	preload("res://Assets/Art/icon.svg")  # Tier 3 (replace later)
]

func _ready():
	# Start with one press (tier 1 unlocked by default)
	var first_press = create_press(1)
	$ScrollContainer/VBoxContainer.add_child(first_press)
	press_nodes.append(first_press)

	update_ui()

func _process(delta):
	for i in range(press_nodes.size()):
		if i >= CraftingManager.presses.size():
			continue

		var data = CraftingManager.presses[i]
		var bar = press_nodes[i].get_node("ProgressBar")
		bar.value = data.progress * 100

	update_ui()

# ---------------------
# Build a press row with a TextureButton + ProgressBar
# ---------------------
func create_press(tier: int) -> HBoxContainer:
	var press_container = HBoxContainer.new()
	press_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	press_container.custom_minimum_size.y = 48
	press_container.add_theme_constant_override("separation", 8)

	# --- Button ---
	var button = TextureButton.new()
	var tex = tier_textures[min(tier - 1, tier_textures.size() - 1)]
	button.texture_normal = tex
	button.texture_disabled = tex
	button.disabled = true
	button.size_flags_horizontal = Control.SIZE_FILL
	button.size_flags_vertical = Control.SIZE_FILL
	button.custom_minimum_size.x = 96
	press_container.add_child(button)

	# --- ProgressBar ---
	var bar = ProgressBar.new()
	bar.name = "ProgressBar"   # <-- Add this line
	bar.min_value = 0
	bar.max_value = 100
	bar.value = 0
	bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bar.size_flags_vertical = Control.SIZE_FILL
	press_container.add_child(bar)

	return press_container

# ---------------------
# Unlock a new press externally (e.g. from shop)
# ---------------------
func unlock_press(tier: int):
	var new_press = create_press(tier)
	$ScrollContainer/VBoxContainer.add_child(new_press)
	press_nodes.append(new_press)

func update_ui():
	$HBoxContainer/CasingsLabel.text = "Casings: " + str(PlayerData.casings)
	$HBoxContainer/BulletsLabel.text = "Bullets: " + str(PlayerData.bullets)

func _on_back_pressed():
	if PlayerData.current_gun_scene != "":
		get_tree().change_scene_to_file(PlayerData.current_gun_scene)
	else:
		print("Error: current_gun_scene not set!")
