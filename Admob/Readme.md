# Godot AdMob Manager (Godot 4)

Production Ready AdMob Manager for Godot 4.

Supports:

- Banner Ads
- Interstitial Ads
- Rewarded Ads
- Rewarded Interstitial Ads
- Retry Logic
- Auto Reload
- Pause / Resume
- Reward Callback
- Global Access

---

# Features

✅ Banner Ads  
✅ Interstitial Ads  
✅ Rewarded Ads  
✅ Rewarded Interstitial Ads  
✅ Retry System  
✅ Auto Reload  
✅ Pause / Resume  
✅ Reward Callback  
✅ Global Access  
✅ Production Ready  
✅ Beginner Friendly  

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

Install plugin.

IMPORTANT:

Enable:

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

Without Android build template ads may not work.

---

# STEP 4 — Create AdManager Scene

Create new scene.

Root node:

```text
Node
```

Rename:

```text
AdManager
```

Add child node:

```text
Admob
```

Final structure:

```text
AdManager
│
└── Admob
```

---

# STEP 5 — Attach Script

Attach:

```text
AdManager.gd
```

to:

```text
AdManager
```

Correct structure:

```text
AdManager
│
├── AdManager.gd
│
└── Admob
```

---

# STEP 6 — Setup Test IDs

Select:

```text
Admob
```

In Inspector add TEST IDs.

---

# Android App ID

```text
ca-app-pub-3940256099942544~3347511713
```

---

# iOS App ID

```text
ca-app-pub-3940256099942544~1458002511
```

---

# Banner Test ID

## Android

```text
ca-app-pub-3940256099942544/6300978111
```

## iOS

```text
ca-app-pub-3940256099942544/2934735716
```

---

# Interstitial Test ID

## Android

```text
ca-app-pub-3940256099942544/1033173712
```

## iOS

```text
ca-app-pub-3940256099942544/4411468910
```

---

# Rewarded Test ID

## Android

```text
ca-app-pub-3940256099942544/5224354917
```

## iOS

```text
ca-app-pub-3940256099942544/1712485313
```

---

# Rewarded Interstitial Test ID

## Android

```text
ca-app-pub-3940256099942544/5354046379
```

## iOS

```text
ca-app-pub-3940256099942544/6978759866
```

---

# STEP 7 — is_real Setup

Inside Inspector:

```text
is_real
```

For testing:

```text
false
```

For production:

```text
true
```

IMPORTANT:

Never click your own real ads.

---

# STEP 8 — Add AdManager As AutoLoad

Go to:

```text
Project → Project Settings → Autoload
```

Add:

```text
AdManager.tscn
```

Name:

```text
AdManager
```

Now AdManager becomes global.

You can use it from ANY scene.

---

# STEP 9 — Android Permissions

Go to:

```text
Project → Export
```

Create Android export preset.

Enable:

- INTERNET
- ACCESS_NETWORK_STATE

---

# STEP 10 — Export APK

Export APK.

IMPORTANT:

Ads work properly on REAL Android devices.

Ads may not work correctly inside editor.

---

# HOW THE SYSTEM WORKS

AdManager automatically:

✅ Initializes AdMob  
✅ Loads Ads  
✅ Retries Failed Ads  
✅ Reloads Ads  
✅ Pauses Game During Ads  
✅ Resumes Game After Ads  

You do NOT need to manually reload ads.

---

# HOW TO USE ADS

---

# Banner Ads

Banner ads are small ads.

Usually shown at bottom.

---

# Show Banner

```gdscript
AdManager.show_banner()
```

---

# Hide Banner

```gdscript
AdManager.hide_banner()
```

---

# Example

## MainMenu.gd

```gdscript
func _ready():

	AdManager.show_banner()
```

---

# Recommended Places

✅ Main Menu  
✅ Pause Menu  
✅ Shop Screen  

---

# Interstitial Ads

Interstitial ads are fullscreen ads.

---

# Show Interstitial

```gdscript
AdManager.show_interstitial()
```

---

# Example — Game Over

```gdscript
func game_over():

	AdManager.show_interstitial()
```

---

# Example — Every 3 Levels

```gdscript
var level_count := 0

func level_complete():

	level_count += 1

	if level_count % 3 == 0:

		AdManager.show_interstitial()
```

---

# Recommended Places

✅ Level Complete  
✅ Game Over  
✅ Retry Level  
✅ Every Few Levels  

---

# Rewarded Ads

Rewarded ads give reward after watching ad.

---

# Show Rewarded Ad

```gdscript
AdManager.show_rewarded(reward_player)
```

---

# Example — Revive Player

```gdscript
func _on_revive_pressed():

	AdManager.show_rewarded(revive_player)
```

---

# Reward Function

```gdscript
func revive_player():

	player.revive()
```

---

# Example — Hint Reward

```gdscript
func _on_hint_pressed():

	AdManager.show_rewarded(give_hint)
```

---

# Reward Function

```gdscript
func give_hint():

	hints += 1
```

---

# Rewarded Flow

```text
Player Clicks Reward Button
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

# Rewarded Interstitial Ads

Rewarded Interstitial is combination of:

- Rewarded Ads
- Interstitial Ads

Fullscreen ad + reward.

---

# Show Rewarded Interstitial

```gdscript
AdManager.show_rewarded_interstitial(
	give_bonus
)
```

---

# Example — Double Coins

```gdscript
func _on_double_reward_pressed():

	AdManager.show_rewarded_interstitial(
		double_coins
	)
```

---

# Reward Function

```gdscript
func double_coins():

	coins *= 2
```

---

# Example — Extra Stars

```gdscript
func _on_extra_star_pressed():

	AdManager.show_rewarded_interstitial(
		give_extra_star
	)
```

---

# Reward Function

```gdscript
func give_extra_star():

	stars += 1
```

---

# Ready Checks

Use before showing ads.

---

# Banner Ready

```gdscript
AdManager.is_banner_ready()
```

---

# Interstitial Ready

```gdscript
AdManager.is_interstitial_ready()
```

---

# Rewarded Ready

```gdscript
AdManager.is_rewarded_ready()
```

---

# Rewarded Interstitial Ready

```gdscript
AdManager.is_rewarded_interstitial_ready()
```

---

# Example Ready Check

```gdscript
if AdManager.is_rewarded_ready():

	AdManager.show_rewarded(give_reward)

else:

	print("Rewarded Ad Not Ready")
```

---

# Retry System

If internet fails:

Ads retry automatically.

Default:

```gdscript
retry_time = 3.0
max_retries = 5
```

Meaning:

- Retry every 3 seconds
- Maximum 5 retries

---

# Recommended Ad Strategy

# Banner

Best for:

- Main Menu
- Pause Menu
- Shop

---

# Interstitial

Best for:

- Level Complete
- Game Over
- Retry
- Every Few Levels

---

# Rewarded

Best for:

- Revive
- Hint
- Skip Level
- Extra Coins

---

# Rewarded Interstitial

Best for:

- Double Rewards
- Bonus Rewards
- Continue Streak
- Extra Stars

---

# Recommended Structure

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

# Example Real Usage

# Main Menu

```gdscript
func _ready():

	AdManager.show_banner()
```

---

# Game Over

```gdscript
func game_over():

	AdManager.show_interstitial()
```

---

# Revive Button

```gdscript
func _on_revive_pressed():

	AdManager.show_rewarded(revive_player)
```

---

# Reward Function

```gdscript
func revive_player():

	player.revive()
```

---

# Rewarded Interstitial Example

```gdscript
func on_bonus_reward_pressed():

	AdManager.show_rewarded_interstitial(
		give_bonus_reward
	)
```

---

# Bonus Reward Function

```gdscript
func give_bonus_reward():

	coins += 500
```

---

# Final Result

You now have:

✅ Banner Ads  
✅ Interstitial Ads  
✅ Rewarded Ads  
✅ Rewarded Interstitial Ads  
✅ Retry System  
✅ Auto Reload Ads  
✅ Pause / Resume  
✅ Reward Callback  
✅ Global Access  
✅ Production Ready Ad System  
✅ Plugin Friendly Structure  

Your AdMob system is now ready for real mobile games using Godot 4.
