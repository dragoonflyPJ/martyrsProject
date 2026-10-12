extends TextureRect

@export var animation_player: AnimationPlayer

func _on_mouse_entered():
	animation_player.play(String(self.name))
