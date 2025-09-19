# res://Gun_Folders/Pistol/p_upgrade.gd
extends Control

@onready var bob_button = $HBoxContainer/BobButton
@onready var bob_label = $HBoxContainer/BobLabel
@onready var neighborhood_button = $HBoxContainer/NeighborhoodButton
@onready var neighborhood_label = $HBoxContainer/NeighborhoodLabel
@onready var police_button = $HBoxContainer/PoliceButton
@onready var police_label = $HBoxContainer/PoliceLabel
@onready var gangs_button = $HBoxContainer/GangsButton
@onready var gangs_label = $HBoxContainer/GangsLabel
@onready var cartel_button = $HBoxContainer2/CartelButton
@onready var cartel_label = $HBoxContainer2/CartelLabel
@onready var government_button = $HBoxContainer2/GovernmentButton
@onready var government_label = $HBoxContainer2/GovernmentLabel
@onready var terrorists_button = $HBoxContainer2/TerroristsButton
@onready var terrorists_label = $HBoxContainer2/TerroristsLabel
@onready var alien_button = $HBoxContainer2/AlienButton
@onready var alien_label = $HBoxContainer2/AlienLabel
@onready var bullets_label = $HBoxContainer3/BulletsLabel

func _ready():
	# Connect all button signals
	bob_button.pressed.connect(_on_bob_button_pressed)
	neighborhood_button.pressed.connect(_on_neighborhood_button_pressed)
	police_button.pressed.connect(_on_police_button_pressed)
	gangs_button.pressed.connect(_on_gangs_button_pressed)
	cartel_button.pressed.connect(_on_cartel_button_pressed)
	government_button.pressed.connect(_on_government_button_pressed)
	terrorists_button.pressed.connect(_on_terrorists_button_pressed)
	alien_button.pressed.connect(_on_alien_button_pressed)
func _process(delta):
	update_all_displays()

func _on_bob_button_pressed():
	var cost = get_bob_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.bobs += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_neighborhood_button_pressed():
	var cost = get_neighborhood_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.neighborhoods += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_police_button_pressed():
	var cost = get_police_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.police += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_gangs_button_pressed():
	var cost = get_gangs_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.gangs += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_cartel_button_pressed():
	var cost = get_cartel_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.cartel += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_government_button_pressed():
	var cost = get_government_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.government += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_terrorists_button_pressed():
	var cost = get_terrorists_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.terrorists += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func _on_alien_button_pressed():
	var cost = get_alien_cost()
	if PlayerData.bullets >= cost:
		PlayerData.bullets -= cost
		PlayerData.aliens += 1
		update_all_displays()
		get_tree().call_group("cps_displays", "update_cps")

func get_bob_cost():
	return 10 + (PlayerData.bobs * 5)

func get_neighborhood_cost():
	return 50 + (PlayerData.neighborhoods * 25)

func get_police_cost():
	return 100 + (PlayerData.police * 50)

func get_gangs_cost():
	return 200 + (PlayerData.gangs * 100)

func get_cartel_cost():
	return 500 + (PlayerData.cartel * 250)

func get_government_cost():
	return 1000 + (PlayerData.government * 500)

func get_terrorists_cost():
	return 2000 + (PlayerData.terrorists * 1000)

func get_alien_cost():
	return 5000 + (PlayerData.aliens * 2500)

func update_all_displays():
	bob_label.text = "Bobs: %d (Cost: %d)" % [PlayerData.bobs, get_bob_cost()]
	neighborhood_label.text = "Neighborhoods: %d (Cost: %d)" % [PlayerData.neighborhoods, get_neighborhood_cost()]
	police_label.text = "Police: %d (Cost: %d)" % [PlayerData.police, get_police_cost()]
	gangs_label.text = "Gangs: %d (Cost: %d)" % [PlayerData.gangs, get_gangs_cost()]
	cartel_label.text = "Cartel: %d (Cost: %d)" % [PlayerData.cartel, get_cartel_cost()]
	government_label.text = "Government: %d (Cost: %d)" % [PlayerData.government, get_government_cost()]
	terrorists_label.text = "Terrorists: %d (Cost: %d)" % [PlayerData.terrorists, get_terrorists_cost()]
	alien_label.text = "Aliens: %d (Cost: %d)" % [PlayerData.aliens, get_alien_cost()]
	bullets_label.text = "Bullets: %d" % int(PlayerData.bullets)


func _on_back_button_pressed():
	var gun_scene_path = "res://Gun_Folders/" + PlayerData.current_gun + "/" + PlayerData.current_gun + ".tscn"
	get_tree().change_scene_to_file(gun_scene_path)
