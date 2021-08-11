extends PanelContainer


var configuration : Car_Configuration

onready var paintjob_options = $VBoxContainer/Paintjob/PaintjobOptions
onready var engine_options = $VBoxContainer/Engine/EngineOptions
onready var rim_options = $VBoxContainer/Rims/RimsOptions
onready var extras = $VBoxContainer/Extras

# Called when the node enters the scene tree for the first time.
func _ready():
	var json_file = File.new()
	json_file.open("res://configurations.json",File.READ)
	var json_string = json_file.get_as_text()
	var json_parseresult : JSONParseResult = JSON.parse(json_string)
	var json = json_parseresult.result
	var car_json = json[0]
	configuration = Car_Configuration.new(car_json)
	extras.connect("changed", self, "on_extras_changed")
	initialize()
	refresh_total_price()
	
func initialize():
	for option in configuration.engines:
		engine_options.add_item(option.get_option_string())
	for option in configuration.paintjobs:
		paintjob_options.add_item(option.get_option_string())
	for option in configuration.rims:
		rim_options.add_item(option.get_option_string())
	
	for option in configuration.extras:
		extras.add_extra(option)
	

func refresh_total_price():
	var total = 0
	total += configuration.base_price
	total += get_price_for_selection(engine_options,configuration.engines)
	total += get_price_for_selection(paintjob_options,configuration.paintjobs)
	total += get_price_for_selection(rim_options,configuration.rims)
	total += extras.get_total_price()
	$VBoxContainer/HBoxContainer5/PriceLabel.text = "%d" % total

func on_extras_changed():
	refresh_total_price()

func get_price_for_selection(options_button, option_array):
	var index = options_button.get_selected_id()
	var engine_option = option_array[index]
	var price = engine_option.price
	return price
	
func _on_EngineOptions_item_selected(index):
	refresh_total_price()

func _on_PaintjobOptions_item_selected(index):
	refresh_total_price()

func _on_RimsOptions_item_selected(index):
	refresh_total_price()
