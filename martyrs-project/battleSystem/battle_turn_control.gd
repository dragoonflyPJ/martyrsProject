extends Node

@export var rootNode:Control
@export var playersNode:Control
@export var playersTurnOrder:VBoxContainer
@export var enemysNode:HFlowContainer

var first_playerEnter = true
var first_player:Control
var actual_player:Control
func _on_players_child_entered_tree(_node): #i get the first player in
	if first_playerEnter:
		first_player = playersNode.get_child(0)
		actual_player = first_player
		first_playerEnter = false



var player_turn_button:TextureButton
func _on_player_turn_order_child_entered_tree(node):
	player_turn_button = node
	player_turn_button.button_up.connect(_on_button_turn_up.bind(player_turn_button))

func _on_button_turn_up(btn:TextureButton):
	
	var switch_player = actual_player

	if btn.name == "turnHalk":
		actual_player = playersNode.get_node("halk_aestas_in_battle")
		if !actual_player.visible:
			#actual_player.visible = true
			print("switch")
			actual_player.get_node("switch").play("enter")
			switch_player.get_node("switch").play("exit") 

	if btn.name == "turnMara":
		actual_player = playersNode.get_node("mara_seerose_in_battle")
		if !actual_player.visible:
			#actual_player.visible = true
			print("switch")
			actual_player.get_node("switch").play("enter")   
			switch_player.get_node("switch").play("exit")  

	print(switch_player.name, actual_player.name)
