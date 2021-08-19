extends PanelContainer

export (PackedScene) var summary_scene
var summary
var configuration : Car_Configuration setget set_configuration

onready var paintjob_options = $VBoxContainer/Paintjob/PaintjobOptions
onready var engine_options = $VBoxContainer/Engine/EngineOptions
onready var rim_options = $VBoxContainer/Rims/RimsOptions
onready var extras = $VBoxContainer/Extras

# Called when the node enters the scene tree for the first time.
func _ready():	
	extras.connect("changed", self, "on_extras_changed")
#	initialize()
#	refresh_total_price()

func set_configuration(_config):
	configuration = _config
	clear()
	initialize()

func clear():
	engine_options.clear()
	paintjob_options.clear()
	rim_options.clear()
	extras.clear()
	if summary:
		summary.queue_free()
		summary = null

func initialize():
	$VBoxContainer/Car_Model2/Car_Model_Label.text = configuration.car_name
	$VBoxContainer/Base_Price/Price.text = "%d Euro" % configuration.base_price
	for option in configuration.engines:
		engine_options.add_item(option.get_option_string())
	for option in configuration.paintjobs:
		paintjob_options.add_item(option.get_option_string())
	for option in configuration.rims:
		rim_options.add_item(option.get_option_string())
	
	for option in configuration.extras:
		extras.add_extra(option)
	
	refresh_total_price()
	
	
func refresh_total_price():
	$VBoxContainer/HBoxContainer5/PriceLabel.text = "%d" % get_total_price_for_selections()

func get_total_price_for_selections():
	var total = 0
	total += configuration.base_price
	total += get_price_for_selection(engine_options,configuration.engines)
	total += get_price_for_selection(paintjob_options,configuration.paintjobs)
	total += get_price_for_selection(rim_options,configuration.rims)
	total += extras.get_total_price()
	return total

func on_extras_changed():
	refresh_total_price()

func get_price_for_selection(options_button, option_array):
	var option = get_selection(options_button, option_array)
	var price = option.price
	return price

func get_selection(options_button, option_array):
	var index = options_button.get_selected_id()
	var option = option_array[index]
	return option
	
func _on_EngineOptions_item_selected(index):
	refresh_total_price()

func _on_PaintjobOptions_item_selected(index):
	refresh_total_price()

func _on_RimsOptions_item_selected(index):
	refresh_total_price()



func _on_Buy_Button_pressed():
	if summary:
		summary.queue_free()
		summary = null
	summary = summary_scene.instance()
	var car_configuration = Car_Configuration.new()
	car_configuration.base_price = configuration.base_price
	car_configuration.engines = [get_selection(engine_options,configuration.engines)]
	car_configuration.paintjobs = [get_selection(paintjob_options, configuration.paintjobs)]
	car_configuration.rims = [get_selection(rim_options, configuration.rims)]
	car_configuration.extras = extras.get_selected_extras()
	car_configuration.cached_total = get_total_price_for_selections()
	summary.configuration = car_configuration
	$VBoxContainer.add_child(summary)
