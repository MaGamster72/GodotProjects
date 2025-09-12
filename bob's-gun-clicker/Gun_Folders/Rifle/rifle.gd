extends Control

# ---------------------
# Gun button pressed
# ---------------------
func _on_gun_button_pressed():
	PlayerData.casings += 1  # Generate a casing
	update_ui()

func _ready():
	PlayerData.current_gun_scene = "res://Gun_Folders/Rifle/Rifle"  # change per gun


func update_ui():
	$HBoxContainer/CasingsLabel.text = "Casings: " + str(PlayerData.casings)
	$HBoxContainer/BulletsLabel.text = "Bullets: " + str(PlayerData.bullets)
	

func _process(delta):
	# Continuously update the UI in case crafting changes values
	update_ui()




func _on_crafting_button_pressed():
	get_tree().change_scene_to_file("res://Extra Scenes/Crafting.tscn")


func _on_research_button_pressed():
	get_tree().change_scene_to_file("res://Extra Scenes/ResearchHub.tscn")


func _on_upgrade_button_pressed():
	get_tree().change_scene_to_file("res://Gun_Folders/Rifle/r_upgrade.tscn")


func _on_advance_button_pressed():
	get_tree().change_scene_to_file("res://Gun_Folders/Rifle/Rifle.tscn") #Make sure to change for every gun


#Make setting and prestige screen
#Also need to figure out how prestige is gonna work. Think it was golden bullets that give you a % boost
