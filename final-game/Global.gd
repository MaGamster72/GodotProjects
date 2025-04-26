extends Node

signal bat_trigger_attack  # Signal for the bat to attack

# This function will be called from the level scene when the bat enters
func trigger_bat_attack():
	emit_signal("bat_trigger_attack")
