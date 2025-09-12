extends Node

# ---------------------
# Press Class
# ---------------------
class Press:
	var tier: int       # Determines texture and strength
	var rate: int       # Casings consumed per cycle
	var speed: float    # Time to finish cycle
	var output: int     # Bullets produced per cycle
	var progress: float = 0.0
	var is_active: bool = false

	func _init(_tier: int, _rate: int, _speed: float, _output: int):
		tier = _tier
		rate = _rate
		speed = _speed
		output = _output
		progress = 0.0
		is_active = false

# ---------------------
# List of all presses
# ---------------------
var presses: Array = []

func _ready():
	if presses.is_empty():
		# Start with only Tier 1 press
		presses.append(Press.new(1, 1, 3.0, 1))
	set_process(true)

# ---------------------
# Background crafting
# ---------------------
func _process(delta: float) -> void:
	for press in presses:
		if PlayerData.casings >= press.rate:
			if not press.is_active:
				press.is_active = true
				press.progress = 0.0
				PlayerData.casings -= press.rate

			press.progress += delta / press.speed
			if press.progress >= 1.0:
				PlayerData.bullets += press.output
				press.progress = 0.0
				press.is_active = false

# ---------------------
# Unlock/Add new press dynamically
# ---------------------
func unlock_press(tier: int, rate: int, speed: float, output: int) -> void:
	# Prevent duplicates of the same tier
	for press in presses:
		if press.tier == tier:
			return

	var new_press = Press.new(tier, rate, speed, output)
	presses.append(new_press)
	print("Unlocked new press: Tier", tier)
