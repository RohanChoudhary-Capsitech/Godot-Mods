# README - Complete AdMob Setup Guide for Godot (Android + iOS)

A complete step-by-step guide for integrating AdMob in Godot using the Admob plugin.

This setup supports:

* Banner Ads
* Interstitial Ads
* Rewarded Ads
* Retry Logic
* Auto Reload
* Pause/Resume Game
* Debug/Test Ads
* Real Ads for Production
* Android + iOS Support

---

# Plugin Used

AdMob Plugin for Godot

Features:

* Banner Ads
* Interstitial Ads
* Rewarded Ads
* Rewarded Interstitial
* App Open Ads
* Native Ads
* UMP Consent Support
* iOS ATT Support
* Ad Caching
* Mediation Support

---

# STEP 1 — Install AdMob Plugin

## Via AssetLib (Recommended)

Open Godot.

Go to:

```text
AssetLib
```

Search:

```text
Admob
```

Download:

* Android version
* iOS version (optional if using iOS)

IMPORTANT:

When install popup opens:

* Keep default install location
* Enable:

```text
Ignore asset root
```

Click:

```text
Install
```

---

# STEP 2 — Enable Plugin

Go to:

```text
Project → Project Settings → Plugins
```

Enable:

```text
Admob
```

---

# STEP 3 — Install Android Build Template

Go to:

```text
Project → Install Android Build Template
```

Click:

```text
Install
```

IMPORTANT:

Without this ads may not work.

---

# STEP 4 — Scene Setup

Your scene should look like this:

```text
TestScene
│
└── Admob
```

Example:

```text
TestScene (Node2D)
│
└── Admob
```

IMPORTANT:

* Select root node
* Click "+"
* Search:

```text
Admob
```

* Add it

---

# STEP 5 — Configure Admob Node

Select:

```text
Admob
```

In Inspector you will see:

* Android Application ID
* iOS Application ID
* Banner Ad IDs
* Interstitial Ad IDs
* Rewarded Ad IDs
* is_real option

---

# STEP 6 — Add TEST App IDs

## Android TEST APP ID

```text
ca-app-pub-3940256099942544~3347511713
```

## iOS TEST APP ID

```text
ca-app-pub-3940256099942544~1458002511
```

Paste inside:

```text
Android Application ID
iOS Application ID
```

---

# STEP 7 — Add TEST Ad Unit IDs

## Banner Test IDs

### Android

```text
ca-app-pub-3940256099942544/6300978111
```

### iOS

```text
ca-app-pub-3940256099942544/2934735716
```

---

## Interstitial Test IDs

### Android

```text
ca-app-pub-3940256099942544/1033173712
```

### iOS

```text
ca-app-pub-3940256099942544/4411468910
```

---

## Rewarded Test IDs

### Android

```text
ca-app-pub-3940256099942544/5224354917
```

### iOS

```text
ca-app-pub-3940256099942544/1712485313
```

---

# STEP 8 — is_real Setup

Inside Inspector find:

```text
is_real
```

For testing:

```text
is_real = false
```

IMPORTANT:

During development ALWAYS use:

```text
false
```

---

# STEP 9 — Real Ads Setup

When releasing your game:

Set:

```text
is_real = true
```

AND replace all test IDs with your real AdMob IDs.

IMPORTANT:

Never click your own real ads.

---

# STEP 10 — Android Permissions

Go to:

```text
Project → Export
```

Create Android Export Preset.

Go to:

```text
Android → Permissions
```

Enable:

* INTERNET
* ACCESS_NETWORK_STATE

---

# STEP 11 — Attach Script

Attach your AdManager script to:

```text
TestScene
```

NOT on Admob node.

Scene structure:

```text
TestScene
│
├── Script Attached Here
│
└── Admob
```

---

# STEP 12 — Access Admob Node

Inside script:

```gdscript
@onready var admob = $Admob
```

---

# STEP 13 — Initialize AdMob

Example:

```gdscript
extends Node2D

@onready var admob = $Admob

func _ready():

    admob.initialization_completed.connect(_on_init)

    admob.initialize()


func _on_init(status):

    print("Admob Initialized ✅")
```

---

# STEP 14 — Banner Ad Setup

## Load Banner

```gdscript
func load_banner():

    admob.load_banner_ad()
```

## Show Banner

```gdscript
func _on_banner_loaded(ad_info, response_info):

    admob.show_banner_ad()
```

---

# STEP 15 — Interstitial Ad Setup

## Load Interstitial

```gdscript
func load_interstitial():

    admob.load_interstitial_ad()
```

## Show Interstitial

```gdscript
func _on_interstitial_loaded(ad_info, response_info):

    admob.show_interstitial_ad()
```

---

# STEP 16 — Rewarded Ad Setup

## Load Rewarded

```gdscript
func load_rewarded():

    admob.load_rewarded_ad()
```

## Show Rewarded

```gdscript
func _on_rewarded_loaded(ad_info, response_info):

    admob.show_rewarded_ad()
```

---

# STEP 17 — Current Setup (Button Based)

Right now ads work using buttons.

Example:

```gdscript
_on_banner_pressed()

_on_interstitial_pressed()

_on_rewarded_pressed()
```

Flow:

```text
Button Click → Load Ad → Show Ad
```

---

# STEP 18 — Future Setup (Without Buttons)

Later you can show ads automatically from gameplay.

---

## Example — Show Interstitial After Level Complete

```gdscript
func level_complete():

    load_interstitial()
```

---

## Example — Show Rewarded For Revive

```gdscript
func revive_player():

    load_rewarded()
```

---

## Example — Auto Banner On Game Start

```gdscript
func _ready():

    load_banner()
```

---

# STEP 19 — Retry System

Your setup already includes retry logic.

Example:

```gdscript
retry_time = 3.0
max_retries = 5
```

Meaning:

* retry every 3 seconds
* maximum 5 retries

---

## Retry Example

```gdscript
func _on_banner_failed(ad_info, error):

    await get_tree().create_timer(retry_time).timeout

    load_banner()
```

---

# STEP 20 — Pause/Resume Game During Ads

## Pause Game

```gdscript
get_tree().paused = true
```

## Resume Game

```gdscript
get_tree().paused = false
```

IMPORTANT:

Use:

```gdscript
process_mode = Node.PROCESS_MODE_ALWAYS
```

Otherwise ads may stop working while game is paused.

---

# STEP 21 — Recommended Real Game Flow

## Banner Ads

* load once
* keep visible

---

## Interstitial Ads

Show:

* after level complete
* after game over
* after few retries

---

## Rewarded Ads

Show only when user wants reward.

Example:

* revive
* extra coins
* unlock hint

---

# STEP 22 — Export APK

Go to:

```text
Project → Export
```

Export Android APK.

IMPORTANT:

Test ads on REAL Android device.

Ads may not work correctly inside editor.

---

# STEP 23 — Final Checklist

Before testing:

* Plugin enabled
* Android build template installed
* App IDs added
* Ad IDs added
* INTERNET permission enabled
* is_real = false
* Testing on real device

---

# IMPORTANT WARNING

* NEVER click your own real ads
* Use test ads during development
* Use real ads only after publishing

---

# Final Result

You now have:

* Full AdMob Setup
* Android + iOS Support
* Banner Ads
* Interstitial Ads
* Rewarded Ads
* Retry Logic
* Pause/Resume System
* Button-Based Ads
* Future Auto-Ad Support
* Production Ready Setup

---
