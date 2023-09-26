@tool
extends Control


var session_time = 0
var total_time = 0
var save : ConfigFile = ConfigFile.new()
const PATH_TO_SAVE_FILE = "user://time_in_project.ini"


func _enter_tree() -> void:
	read_file()


func _exit_tree() -> void:
	save_file()


func _process(delta: float) -> void:
	pass


func read_file():
	if not FileAccess.file_exists(PATH_TO_SAVE_FILE):
		return
	
	var file = FileAccess.open(PATH_TO_SAVE_FILE, FileAccess.READ)


func save_file():
	pass
