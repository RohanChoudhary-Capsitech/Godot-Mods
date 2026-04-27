@tool
extends EditorPlugin

func _enter_tree():

	add_autoload_singleton(
		"Localization",
		"res://addons/localization_plugin/LocalizationManager.gd"
	)


func _exit_tree():

	remove_autoload_singleton("Localization")
