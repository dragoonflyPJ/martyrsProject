extends Node

@export var turnLabel:Label
@export var rootNode:Control
@export var playersNode:Control
@export var playersTurnOrder:VBoxContainer
@export var enemysNode:HFlowContainer

var first_playerEnter = true
var first_player:Control
var actual_player:Control

func next_turn():
	self.set_meta("turn", self.get_meta("turn")+1)
	turnLabel.text = "Turn "+ str(self.get_meta("turn"))

func _on_meta_change(_meta_name, _value):
	print("funciona")

func _on_players_child_entered_tree(_node): #i get the first player in
	if first_playerEnter:
		first_player = playersNode.get_child(0)
		actual_player = first_player
		first_playerEnter = false

var player_turn_button:TextureButton
func _on_player_turn_order_child_entered_tree(node):
	player_turn_button = node
	player_turn_button.button_up.connect(_on_button_turn_up.bind(player_turn_button))

func button_turn_action(if_:String, button:TextureButton, put_:String):
	# Generate the player switch logic
	var switch_player = actual_player

	if button.name == if_:
		actual_player = playersNode.get_node(put_)
		if !actual_player.visible:
			actual_player.get_node("switch").play("enter")
			switch_player.get_node("switch").play("exit")
			next_turn() 	

func _on_button_turn_up(btn:TextureButton):
	
	button_turn_action("turnHalk", btn, "halk_aestas_in_battle")
	button_turn_action("turnMara", btn, "mara_seerose_in_battle")

