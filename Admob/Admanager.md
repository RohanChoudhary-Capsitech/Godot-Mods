# README — Complete AdManager Setup Guide For Godot

This guide will help you setup a complete Ad Manager system in Godot Engine using Google AdMob.

Even if you are beginner, you can follow this step-by-step.

---

# What You Will Get

After setup you will have:

✅ Banner Ads
✅ Interstitial Ads
✅ Rewarded Ads
✅ Retry System
✅ Auto Reload Ads
✅ Pause Game During Ads
✅ Resume Game After Ads
✅ Global AdManager
✅ Production Ready Setup

---

# STEP 1 — Install AdMob Plugin

Open Godot.

Go to:

```text
AssetLib
```

Search:

```text
Admob
```

Install the plugin.

IMPORTANT:

While installing:

✅ Enable:

```text
Ignore asset root
```

Then click:

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

# STEP 4 — Create AdManager Scene

Create a new scene.

Root node:

```text
Node
```

Rename it:

```text
AdManager
```

Now add child node.

Click:

```text
+
```

Search:

```text
Admob
```

Add it.

Your scene should look like this:

```text
AdManager
│
└── Admob
```

---

# STEP 5 — Attach AdManager Script

Attach your `AdManager.gd` script to:

```text
AdManager
```

NOT on Admob node.

Correct:

```text
AdManager
│
├── AdManager.gd
│
└── Admob
```

Wrong:

```text
Admob
│
└── AdManager.gd
```

---

# STEP 6 — Setup Test IDs

Select:

```text
Admob
```

In Inspector add these TEST IDs.

---

# Android Test App ID

```text
ca-app-pub-3940256099942544~3347511713
```

---

# iOS Test App ID

```text
ca-app-pub-3940256099942544~1458002511
```

---

# Banner Test ID

Android:

```text
ca-app-pub-3940256099942544/6300978111
```

iOS:

```text
ca-app-pub-3940256099942544/2934735716
```

---

# Interstitial Test ID

Android:

```text
ca-app-pub-3940256099942544/1033173712
```

iOS:

```text
ca-app-pub-3940256099942544/4411468910
```

---

# Rewarded Test ID

Android:

```text
ca-app-pub-3940256099942544/5224354917
```

iOS:

```text
ca-app-pub-3940256099942544/1712485313
```

---

# STEP 7 — is_real Setup

Inside Admob inspector find:

```text
is_real
```

For testing:

```text
false
```

IMPORTANT:

During testing ALWAYS use:

```text
false
```

---

# STEP 8 — Add AdManager As AutoLoad

Go to:

```text
Project → Project Settings → Autoload
```

Select your:

```text
AdManager.tscn
```

Name:

```text
AdManager
```

Click:

```text
Add
```

IMPORTANT:

Now AdManager works globally in whole game.

You can use ads from ANY scene.

---

# STEP 9 — Android Permissions

Go to:

```text
Project → Export
```

Create Android export preset.

Enable permissions:

✅ INTERNET
✅ ACCESS_NETWORK_STATE

---

# STEP 10 — Export APK

Export APK.

IMPORTANT:

Ads work properly on REAL Android device.

Sometimes ads do NOT work inside editor.

---

# HOW ADS WORK

Your system automatically:

✅ initializes ads
✅ loads ads
✅ retries failed ads
✅ reloads after close

You do NOT need to manually reload every time.

---

# HOW TO USE ADS IN GAME

VERY IMPORTANT SECTION

This is how you use ads in your game.

---

# 1 — Banner Ads

Banner ads are small ads.

Usually shown at bottom.

---

## Show Banner

Example:

```gdscript
AdManager.show_banner()
```

---

## Hide Banner

Example:

```gdscript
AdManager.hide_banner()
```

---

# WHERE TO USE BANNER

Good places:

✅ Main Menu
✅ Pause Menu
✅ Shop Screen

---

## Example

MainMenu.gd

```gdscript
func _ready():

	AdManager.show_banner()
```

---

# 2 — Interstitial Ads

These are full screen ads.

---

## Show Interstitial

```gdscript
AdManager.show_interstitial()
```

---

# WHERE TO USE INTERSTITIAL

Good places:

✅ Level Complete
✅ Game Over
✅ After 2-3 matches
✅ After player dies

---

## Example — Game Over

```gdscript
func game_over():

	AdManager.show_interstitial()
```

---

## Example — Level Complete

```gdscript
func level_complete():

	AdManager.show_interstitial()
```

---

# 3 — Rewarded Ads

Rewarded ads give reward to player.

---

## Show Rewarded

```gdscript
AdManager.show_rewarded(reward_player)
```

---

# IMPORTANT

Reward ONLY after player watches ad.

---

# Example — Revive Player

```gdscript
func on_revive_button_pressed():

	AdManager.show_rewarded(revive_player)
```

---

## Reward Function

```gdscript
func revive_player():

	player_health = 100

	print("Player Revived")
```

---

# FULL REWARDED FLOW

```text
Player Clicks Revive
        ↓
Rewarded Ad Opens
        ↓
Player Watches Ad
        ↓
Reward Function Runs
        ↓
Player Gets Reward
```

---

# IMPORTANT — Game Pause

Game automatically pauses during ads.

You do NOT need to manually pause game.

Already handled inside AdManager.

---

# RETRY SYSTEM

If internet fails:

Your ads retry automatically.

Current setup:

```gdscript
retry_time = 3.0
max_retries = 5
```

Meaning:

✅ retry every 3 seconds
✅ maximum 5 retries

---

# REAL ADS SETUP

When publishing game:

Replace TEST IDs with REAL IDs.

Set:

```text
is_real = true
```

IMPORTANT:

NEVER click your own real ads.

---

# RECOMMENDED AD FLOW

Best setup:

---

## Banner

```text
Main Menu
Shop
Pause Screen
```

---

## Interstitial

```text
Game Over
Level Complete
Every few rounds
```

---

## Rewarded

```text
Revive
Extra Coins
Double Reward
Unlock Hint
```

---

# FINAL STRUCTURE

Recommended structure:

```text
Autoloads
│
└── AdManager

Scenes
│
├── MainMenu
├── Gameplay
├── Shop
└── GameOver
```

---

# EXAMPLE REAL USAGE

---

## Main Menu

```gdscript
func _ready():

	AdManager.show_banner()
```

---

## Game Over

```gdscript
func game_over():

	AdManager.show_interstitial()
```

---

## Revive Button

```gdscript
func _on_revive_pressed():

	AdManager.show_rewarded(revive_player)
```

---

## Reward Function

```gdscript
func revive_player():

	player.revive()
```

---

# FINAL RESULT

Now you have:

✅ Professional AdManager
✅ Retry System
✅ Auto Reload Ads
✅ Rewarded System
✅ Global Ad Access
✅ Production Ready Setup
✅ Beginner Friendly Structure

Your ad system is now ready for real mobile games in Godot Engine using Google AdMob.
