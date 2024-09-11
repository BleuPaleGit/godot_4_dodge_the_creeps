class_name SaveData extends Resource

@export var highscore_names: Array = ["MOYO", "Yari", "GOober", "Blö", "Boyo"]
@export var highscore_values: Array = [31, 25, 23, 18, 13]
@export var highscore_index: int = 0

const SAVE_PATH:String = "user://leaderboard.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_or_create() -> SaveData:
	var res:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
		
	else:
		res = SaveData.new()
	
	return res
