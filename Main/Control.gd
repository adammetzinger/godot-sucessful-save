extends Control

signal change_health

var action = ""

func _on_plus_button_pressed():
	action = "+"
	emit_signal("change_health", action)

func _on_minus_button_pressed():
	action = "-"
	emit_signal("change_health", action)
