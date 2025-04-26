extends MarginContainer

func update_round(value):
	# Assuming the label is $HUD/HBoxContainer2/Number
	var number_label = $HBoxContainer2/Number
	number_label.text = str(value)  # Set the text to the rounded value
