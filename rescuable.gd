extends Node2D

@export var worth = 450

func _ready():
	$sprite.play("default")
	
	print("Rescuable initialised")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_body_entered(body):
	if body == Main.player_body:
		print("Player entered rescuable.")
		Main.player_body.rescue_possible(self)
