extends Control

func _on_player_update_ui(health, playerPos):
	$CurrentHealth.text = "Current Health: " + str(health)
	$CurrentPos.text = "Current Position: " + str(playerPos)
