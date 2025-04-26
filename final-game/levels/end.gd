extends Area2D

signal bat_entered_area  # Define the signal


func _on_area_entered(area):
	if area.is_in_group("enemy"):  # Ensure it's the bat
		Global.trigger_bat_attack()  # Trigger the global signal
