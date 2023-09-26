@tool
extends Control


@export var total_time_label_path : NodePath
@export var session_time_label_path : NodePath
var session_time = 0.0
var total_time = 0.0
const PATH_TO_SAVE_FILE = "user://time_in_project.save"
@onready var total_time_label : Label = get_node(total_time_label_path)
@onready var session_time_label : Label = get_node(session_time_label_path)


func _enter_tree() -> void:
	read_file()


func _exit_tree() -> void:
	save_file()


func _process(delta: float) -> void:
	session_time += delta
	total_time += delta
	
	set_time()


func set_time():
	total_time_label.text = "Time in project: " + Time.get_time_string_from_unix_time(total_time)
	session_time_label.text = "Time this session: " + Time.get_time_string_from_unix_time(session_time)


func read_file():
	if not FileAccess.file_exists(PATH_TO_SAVE_FILE):
		return
	
	var save = FileAccess.open(PATH_TO_SAVE_FILE, FileAccess.READ)
	
	var json_string := ""
	while save.get_position() < save.get_length():
		json_string += save.get_line()
	
	var parsed_result = JSON.parse_string(json_string)
	
	total_time = float(parsed_result['time'])
	


func save_file():
	var save = FileAccess.open(PATH_TO_SAVE_FILE, FileAccess.WRITE)
	save.store_line(JSON.stringify({'time': roundf(total_time)}, "\t"))
