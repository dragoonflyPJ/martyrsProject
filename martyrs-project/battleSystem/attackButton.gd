extends TextureButton

@export var animation_player: AnimationPlayer

func _ready():
	self.connect("button_up", _on_button_up)

func _on_mouse_entered():
	animation_player.play(String(self.name))

func _on_button_up():

	var sceneRoot = self.get_tree().root.get_child(0)
	
	if self.name == "attack0":
		print("Ataque Cero")
		if sceneRoot.name == "battleSystem":
			sceneRoot.get_node("battleTurnControl").next_turn()
		return
	
	if self.name == "attack1":
		print("Ataque Uno")
		if sceneRoot.name == "battleSystem":
			sceneRoot.get_node("battleTurnControl").next_turn()
		return

	if self.name == "attack2":
		print("Ataque Dos")
		if sceneRoot.name == "battleSystem":
			sceneRoot.get_node("battleTurnControl").next_turn()
		return
