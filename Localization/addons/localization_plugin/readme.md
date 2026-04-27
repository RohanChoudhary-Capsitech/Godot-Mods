# Godot JSON Localization Plugin

A simple and easy-to-use JSON-based localization plugin for Godot.

This plugin allows you to change game languages dynamically using JSON files.

---

# Features

* Easy JSON localization
* Dynamic language switching
* Works with Labels & Buttons
* Simple setup
* Reusable in any Godot project
* No `.translation` files needed

---

# Installation

## Step 1 — Copy Plugin

Copy the full folder:

```text
addons/localization_plugin
```

Into your project:

```text
YourProject/addons/localization_plugin
```

---

## Step 2 — Enable Plugin

Open Godot:

```text
Project
→ Project Settings
→ Plugins
```

Enable:

```text
Localization Plugin
```

---

# Folder Structure

```text
addons
└── localization_plugin
	├── plugin.cfg
	├── plugin.gd
	├── LocalizationManager.gd
	└── translations.json
```

---

# Translation File

File path:

```text
res://addons/localization_plugin/translations.json
```

Default example:

```json
{
  "en": {
	"PLAY": "Play",
	"SETTINGS": "Settings",
	"EXIT": "Exit"
  },

  "hi": {
	"PLAY": "खेलो",
	"SETTINGS": "सेटिंग्स",
	"EXIT": "बाहर निकलें"
  }
}
```

---

# Use Your Own JSON File

You can completely replace the default `translations.json` file with your own custom JSON file.

Just keep the same format:

```json
{
  "language_code": {
	"KEY": "Translated Text"
  }
}
```

Example:

```json
{
  "en": {
	"START": "Start Game"
  },

  "fr": {
	"START": "Démarrer le jeu"
  }
}
```

You can add:

* unlimited languages
* unlimited translation keys

---

# Setup UI Nodes

Every Label or Button you want to translate must:

* Be added to the `Localize` group
* Have a metadata key called `translation_key`

---

## Step 1 — Add Group

Select your node.

Open:

```text
Node → Groups
```

Add group:

```text
Localize
```

---

## Step 2 — Add Metadata

In Inspector add metadata:

```text
translation_key = PLAY
```

Example:

```text
translation_key = SETTINGS
translation_key = EXIT
```

---

# Example Scene Setup

```text
MainMenu
├── PlayButton
├── SettingsButton
├── ExitButton
├── HindiButton
└── EnglishButton
```

---

# Example Translation Keys

| Node           | translation_key |
| -------------- | --------------- |
| PlayButton     | PLAY            |
| SettingsButton | SETTINGS        |
| ExitButton     | EXIT            |

---

# Change Language

Use this anywhere in your project:

```gdscript
Localization.set_language("hi")
```

or

```gdscript
Localization.set_language("en")
```

---

# Example Button Script

```gdscript
extends Control


func _ready():

	Localization.set_language("en")


func _on_hindi_pressed() -> void:

	Localization.set_language("hi")


func _on_english_pressed() -> void:

	Localization.set_language("en")
```

---

# Supported Languages

You can add unlimited languages.

Example:

```json
{
  "en": {},
  "hi": {},
  "fr": {},
  "ja": {},
  "ru": {}
}
```

---

# Important Notes

* Do NOT use Godot `.translation` files
* Do NOT use `TranslationServer.set_locale()`
* This plugin uses JSON only

---

# Future Improvements

Possible future features:

* Auto detect device language
* Save selected language
* RTL Arabic support
* Font switching
* CSV to JSON converter
* Editor tools
* Runtime language download

---

# License

Free to use in personal and commercial projects.

---
