extends Control

# HBoxes
@onready var buttons_hbox1 = $HBoxContainer
@onready var buttons_hbox2 = $HBoxContainer2

# Labels manually added in editor
@onready var producer_labels = {
	"Bob": $HBoxContainer/BobLabel,
	"Neighborhood": $HBoxContainer/NeighborhoodLabel,
	"Police": $HBoxContainer/PoliceLabel,
	"Gang": $HBoxContainer/GangsLabel,
	"Cartel": $HBoxContainer2/CartelLabel,
	"Government": $HBoxContainer2/GovernmentLabel,
	"Terrorists": $HBoxContainer2/TerroristsLabel,
	"Aliens": $HBoxContainer2/AlienLabel
}

var button_to_producer = {
	"BobButton": "Bob",
	"NeighborhoodButton": "Neighborhood",
	"PoliceButton": "Police",
	"GangsButton": "Gang",
	"CartelButton": "Cartel",
	"GovernmentButton": "Government",
	"TerroristsButton": "Terrorists",
	"AlienButton": "Aliens"
}

func _ready():
	for hbox in [$HBoxContainer, $HBoxContainer2]:
		print("Checking HBox:", hbox.name)
		for button in hbox.get_children():
			print("Found child:", button.name, "Type:", button)

	# Connect buttons in first HBox
	for button in buttons_hbox1.get_children():
		if button is Button and button.name in button_to_producer:
			var producer = button_to_producer[button.name]
			button.pressed.connect(Callable(self, "buy").bind(producer))

	# Connect buttons in second HBox
	for button in buttons_hbox2.get_children():
		if button is Button and button.name in button_to_producer:
			var producer = button_to_producer[button.name]
			button.pressed.connect(Callable(self, "buy").bind(producer))

	update_ui()

func buy(producer: String):
	print("Attempting to buy: Bob")
	if PlayerData.buy_producer(producer):
		update_ui()

func update_ui():
	$HBoxContainer3/BulletsLabel.text = "Bullets: " + str(PlayerData.bullets)
	var gun = PlayerData.current_gun
	for producer in PlayerData.producers:
		if producer in producer_labels:
			var count = PlayerData.producers_owned[gun][producer]
			var cost = PlayerData.get_producer_cost(producer, count)
			var cps = PlayerData.base_cps[producer] * PlayerData.gun_cps_multiplier[gun]
			producer_labels[producer].text = str(count) + " owned | Cost: " + str(cost) + " | +" + str(cps) + " CPS"

func _on_back_pressed():
	# Use current_gun from PlayerData to determine the scene
	var gun_scene_path = "res://Gun_Folders/" + PlayerData.current_gun + "/" + PlayerData.current_gun + ".tscn"

	# Change to the current gun's scene
	get_tree().change_scene_to_file(gun_scene_path)


func _process(delta):
	# Continuously update the UI in case crafting changes values
	update_ui()





func _on_bob_button_pressed():
	print ("yeet")
