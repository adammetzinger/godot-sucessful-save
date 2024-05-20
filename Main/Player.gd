extends CharacterBody2D
class_name Player
signal update_ui

var health = 100

var save_file_path = "user://save"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	verify_save_directory(save_file_path)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func _physics_process(delta):
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var desired_velocity := int(playerData.speed) * dir
	
	var steering := desired_velocity - velocity
	velocity += steering * 0.15
	
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
	emit_signal("update_ui", playerData.health, self.position)
	playerData.UpdatePos(self.position)

func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	on_start_load()
	print("loaded")

func on_start_load():
	self.position = playerData.SavePos

func save():
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("save")

func take_damage():
	playerData.change_health(-5)
	
func gain_health():
	playerData.change_health(5)
	
func _on_control_change_health(action):
	if action == "+":
		gain_health()
	elif action == "-":
		take_damage()
