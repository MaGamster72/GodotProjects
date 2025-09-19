# res://Gun_Folders/Pistol/pistol.gd
extends Control
@onready var casings_label = $HBoxContainer/CasingsLabel
@onready var bullets_label = $HBoxContainer/BulletsLabel

# ---------------------
# Gun button pressed
# ---------------------
func _on_gun_button_pressed():
	PlayerData.casings += 1  # Generate a casing
	update_ui()

func _ready():
	PlayerData.current_gun_scene = "res://Gun_Folders/Pistol/Pistol.tscn"  # change per gun
	add_to_group("cps_displays")
	update_ui()

func update_ui():
	casings_label.text = "Casings: %d" % int(PlayerData.casings)
	bullets_label.text = "Bullets: %d" % int(PlayerData.bullets)
func update_cps():
	update_ui()

func _process(delta):
	update_ui()




func _on_crafting_button_pressed():
	get_tree().change_scene_to_file("res://Extra Scenes/Crafting.tscn")


func _on_research_button_pressed():
	get_tree().change_scene_to_file("res://Extra Scenes/ResearchHub.tscn")


func _on_upgrade_button_pressed():
	get_tree().change_scene_to_file("res://Gun_Folders/Pistol/p_upgrade.tscn")


func _on_advance_button_pressed():
	get_tree().change_scene_to_file("res://Gun_Folders/Rifle/Rifle.tscn")
