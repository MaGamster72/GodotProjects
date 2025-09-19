extends Node

# -----------------------
# Player currencies
# -----------------------
var casings: float = 0.0
var bullets: int = 0
var current_gun: String = "Pistol"
var current_gun_scene: String = ""

# -----------------------
# Guns and progression
# -----------------------
var guns = ["Pistol", "Rifle", "Shotgun", "AR", "LMG", "Explosives", "Future"]

# -----------------------
# Producers
# -----------------------
var producers = [
	"Bob",
	"Neighborhood",
	"Police",
	"Gang",
	"Cartel",
	"Government",
	"Terrorists",
	"Aliens"
]

# Base CPS per producer
var base_cps = {
	"Bob": .1,
	"Neighborhood": 5,
	"Police": 20,
	"Gang": 50,
	"Cartel": 100,
	"Government": 300,
	"Terrorists": 1000.0,
	"Aliens": 5000
}

# CPS multiplier per gun (how much each producer produces for that gun)
var gun_cps_multiplier = {
	"Pistol": 1.0,
	"Rifle": 5,
	"Shotgun": 7.5,
	"AR": 10,
	"LMG": 50,
	"Explosives": 100.0,
	"Future": 1000.0
}

# Price multiplier per gun (affects cost independently of CPS)
var gun_price_multiplier = {
	"Pistol": 1.0,
	"Rifle": 10.0,
	"Shotgun": 50.0,
	"AR": 100.0,
	"LMG": 500.0,
	"Explosives": 1000.0,
	"Future": 5000.0
}

# Number of each producer owned per gun
var producers_owned = {}

# -----------------------
# Ready
# -----------------------
func _ready():
	# Initialize storage for each gun and producer
	for gun in guns:
		producers_owned[gun] = {}
		for p in producers:
			producers_owned[gun][p] = 0

# -----------------------
# Buy a producer (current gun only)
# -----------------------
func buy_producer(producer: String):
	var gun = current_gun
	var count = producers_owned[gun][producer]
	var cost = get_producer_cost(producer, count)
	if bullets >= cost:
		bullets -= cost
		producers_owned[gun][producer] += 1
		return true
	return false

# -----------------------
# Calculate the cost of a producer
# -----------------------
func get_producer_cost(producer: String, count: int) -> int:
	var base_costs = {
		"Bob": 10,
		"Neighborhood": 100,
		"Police": 1000,
		"Gang": 5000,
		"Cartel": 20000,
		"Government": 100000,
		"Terrorists": 1000000,
		"Aliens": 10000000
	}

	var base_price = base_costs[producer]
	var gun_price_mult = gun_price_multiplier[current_gun]
	var per_owned_mult = pow(1.15, count)

	return int(base_price * gun_price_mult * per_owned_mult)

# -----------------------
# Calculate casings per second for all producers
# Call in _process(delta)
# -----------------------
func process_production(delta):
	for gun in guns:
		var gun_mult = gun_cps_multiplier[gun]
		for p in producers:
			var count = producers_owned[gun][p]
			if count > 0:
				var cps = base_cps[p] * gun_mult
				casings += cps * count * delta

# -----------------------
# Advance to a new gun
# -----------------------
func advance_gun(new_gun: String):
	if new_gun in guns:
		# Reset new gun's producers
		for p in producers:
			producers_owned[new_gun][p] = 0
		current_gun = new_gun
		get_tree().change_scene_to_file("res://Gun_Folders/" + new_gun + "/" + new_gun + ".tscn")
