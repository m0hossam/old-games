extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance() #getting an instance from the scene to use later to add to the world
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position #sets position of grassEffect to position of this node(Grass)
	
func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
