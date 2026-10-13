extends Control

@export_global_file("*.btl") var battle_path:String
@export var players_preloader:ResourcePreloader
@export var enemys_preloader:ResourcePreloader

func load_btl(path:String) -> String:
	
	if not FileAccess.file_exists(path):
		push_error("BattleNotFound at "+path)
		return ""

	var battle_file := FileAccess.open(path, FileAccess.READ)

	if battle_file == null:
		push_error("UneableToOpenBattleFile at "+path)
		return ""

	var battle_text = battle_file.get_as_text()
	battle_file.close()
	return battle_text

func parse_battle(battle_text:String) -> Array:

	var parser_info = []
	var word:String = ""
	for letter in battle_text:
		if letter == "*": break
		if letter == ":": 
			if word != "": parser_info.append(word)
			word = ""
			continue
		if letter == " ": continue
		if letter == "\n":
			if word != "": parser_info.append(word)
			word = ""
			continue
		if letter == "\r": continue
		word += letter

	#print(parser_info)

	return parser_info

func interpretate_battle(parser_info:Array):
	
	var playerVisibility = true
	var enemy_type = ""
	for i in range(0, len(parser_info)-1):

		var opecode = parser_info[i]
		var instruction = parser_info[i+1]

		if opecode == "PLAYER":
			var player_scn:PackedScene = players_preloader.get_resource(instruction)
			var player_instance = player_scn.instantiate()
			self.get_node("players").add_child(player_instance)
			if !playerVisibility:
				player_instance.get_node("switch").play("exit")
				player_instance.get_node("switch").advance(0.60)
				player_instance.visible = false
			if playerVisibility: 
				playerVisibility = false

			var player_turn_scn:PackedScene = players_preloader.get_resource("Turn_"+instruction)
			var player_turn_instance = player_turn_scn.instantiate()
			self.get_node("playerTurnOrder").add_child(player_turn_instance)

		if opecode == "ENEMY_TYPE":
			enemy_type = instruction

		if opecode == "ENEMY_NUMBER":
			for j in range(0, int(instruction)):
				var enemy_scn:PackedScene = enemys_preloader.get_resource(enemy_type+str(randi_range(0, 2)))
				var enemy_instance = enemy_scn.instantiate()
				self.get_node("enemy").add_child(enemy_instance)
				enemy_instance.offset_transform_position += Vector2(randi_range(0, 20)*-1, randi_range(0, 150))#no es problema del interoprete
				enemy_instance.get_node("AnimationPlayer").seek(float(randi_range(0, 2)+float(randi_range(0, 9))/10), true) #no es problema del interprete
			

		

func _ready():
	interpretate_battle(parse_battle(load_btl(battle_path)))

	
