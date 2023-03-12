extends Node3D

var pizza_ressource = preload("res://objects/pizza/pizza.tscn")

signal get_pizza

func _on_area_3d_clicked():
	emit_signal("get_pizza")

func add_pizza():
	var pizza: Node3D = pizza_ressource.instantiate()
	var nb_of_pizzas = $PizzaContainer.get_child_count()
	var random_rotation = randf_range(0, 2*PI)
	pizza.set_rotation(Vector3(0, random_rotation, 0))
	pizza.set_position(Vector3(0, nb_of_pizzas * 0.05, 0))
	$PizzaContainer.add_child(pizza)

func remove_pizza():
	var pizzas: Array[Node] = $PizzaContainer.get_children()
	$PizzaContainer.remove_child(pizzas.back())
