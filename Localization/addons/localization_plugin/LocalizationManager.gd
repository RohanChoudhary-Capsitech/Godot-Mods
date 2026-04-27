extends Node

var translations = {}

var current_language = "en"


func _ready():

	load_translations()


func load_translations():

	var file = FileAccess.open(
		"res://addons/localization_plugin/translations.json",
		FileAccess.READ
	)

	if file:

		translations = JSON.parse_string(
			file.get_as_text()
		)

		file.close()


func set_language(lang):

	current_language = lang

	refresh_ui()


func tr_key(key):

	if translations.has(current_language):

		if translations[current_language].has(key):

			return translations[current_language][key]

	return key


func refresh_ui():

	var nodes = get_tree().get_nodes_in_group("Localize")

	for node in nodes:

		var key = node.get_meta("translation_key")

		if key:

			node.text = tr_key(key)
