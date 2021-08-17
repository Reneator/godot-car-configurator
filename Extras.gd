extends GridContainer

export (PackedScene) var extra_element_scene

signal changed()


func add_extra(option : Car_Option):
	var extra_element : Extras_CheckBox = extra_element_scene.instance()
	extra_element.connect("pressed",self, "on_checkbox_pressed")
	add_child(extra_element)
	extra_element.initialize(option)

func on_checkbox_pressed():
	emit_signal("changed")
	


func get_total_price():
	var total = 0
	for child in get_children():
		if not child.pressed:
			continue
		total += child.get_price()
	return total

func get_selected_extras():
	var extras = []
	for child in get_children():
		if child.pressed:
			extras.append(child.option)
	return extras
