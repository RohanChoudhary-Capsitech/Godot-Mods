#extends Node2D
#@onready var admob=$Admob
#var is_initialized:bool=false
#func _ready():
	#print("start")
	#admob.initialize()
#
#func _on_banner_pressed() -> void:
	#if is_initialized:
		#admob.load_banner_ad()
		#await admob.banner_ad_loaded
		#admob.show_banner_ad()
#
#
#func _on_interstetial_pressed() -> void:
	#if is_initialized:
		#admob.load_interstitial_ad()
		#await admob.interstitial_ad_loaded
		#admob.show_interstitial_ad()
#
#
#func _on_rewarded_pressed() -> void:
	#if is_initialized:
		#print("Reward_Called")
		#admob.load_rewarded_ad()
		#await admob.rewarded_ad_loaded
		#admob.show_rewarded_ad()
#
#
#func _on_admob_initialization_completed(status_data: InitializationStatus) -> void:
	#is_initialized=true
	#print("true")
	
extends Node2D

@onready var admob = $Admob

var is_initialized := false

var is_banner_loaded := false
var is_interstitial_loaded := false
var is_rewarded_loaded := false


# =========================
# RETRY SETTINGS
# =========================
var retry_time := 3.0
var max_retries := 5

var banner_retries := 0
var inter_retries := 0
var reward_retries := 0


func _ready():

	# IMPORTANT
	process_mode = Node.PROCESS_MODE_ALWAYS

	print("AdManager Start 🚀")

	# =========================
	# INIT
	# =========================
	admob.initialization_completed.connect(_on_init)

	# =========================
	# BANNER
	# =========================
	admob.banner_ad_loaded.connect(_on_banner_loaded)
	admob.banner_ad_failed_to_load.connect(_on_banner_failed)

	# =========================
	# INTERSTITIAL
	# =========================
	admob.interstitial_ad_loaded.connect(_on_interstitial_loaded)
	admob.interstitial_ad_failed_to_load.connect(_on_interstitial_failed)

	admob.interstitial_ad_showed_full_screen_content.connect(_on_ad_opened)
	admob.interstitial_ad_dismissed_full_screen_content.connect(_on_interstitial_closed)

	# =========================
	# REWARDED
	# =========================
	admob.rewarded_ad_loaded.connect(_on_rewarded_loaded)
	admob.rewarded_ad_failed_to_load.connect(_on_rewarded_failed)

	admob.rewarded_ad_showed_full_screen_content.connect(_on_ad_opened)
	admob.rewarded_ad_dismissed_full_screen_content.connect(_on_rewarded_closed)

	admob.initialize()


# =========================
# INIT
# =========================
func _on_init(status):

	is_initialized = true

	print("Admob Initialized ✅")


# =========================
# BUTTON FUNCTIONS
# =========================

func _on_banner_pressed():

	if not is_initialized:
		return

	print("Loading Banner...")

	banner_retries = 0

	load_banner()


func _on_interstitial_pressed():

	if not is_initialized:
		return

	print("Loading Interstitial...")

	inter_retries = 0

	load_interstitial()


func _on_rewarded_pressed():

	if not is_initialized:
		return

	print("Loading Rewarded...")

	reward_retries = 0

	load_rewarded()


# =========================
# LOAD FUNCTIONS
# =========================

func load_banner():

	if banner_retries >= max_retries:

		print("Banner max retries reached ❌")

		return


	banner_retries += 1

	print("Banner Retry: ", banner_retries)

	admob.load_banner_ad()


func load_interstitial():

	if inter_retries >= max_retries:

		print("Interstitial max retries reached ❌")

		return


	inter_retries += 1

	print("Interstitial Retry: ", inter_retries)

	admob.load_interstitial_ad()


func load_rewarded():

	if reward_retries >= max_retries:

		print("Rewarded max retries reached ❌")

		return


	reward_retries += 1

	print("Rewarded Retry: ", reward_retries)

	admob.load_rewarded_ad()


# =========================
# CALLBACKS
# =========================

# -------- BANNER --------
func _on_banner_loaded(ad_info, response_info):

	print("Banner Loaded ✅")

	is_banner_loaded = true

	banner_retries = 0

	admob.show_banner_ad()


func _on_banner_failed(ad_info, error):

	print("Banner Failed ❌ ", error.get_message())

	await get_tree().create_timer(retry_time).timeout

	load_banner()


# -------- INTERSTITIAL --------
func _on_interstitial_loaded(ad_info, response_info):

	print("Interstitial Loaded ✅")

	is_interstitial_loaded = true

	inter_retries = 0

	admob.show_interstitial_ad()


func _on_interstitial_failed(ad_info, error):

	print("Interstitial Failed ❌ ", error.get_message())

	await get_tree().create_timer(retry_time).timeout

	load_interstitial()


# -------- REWARDED --------
func _on_rewarded_loaded(ad_info, response_info):

	print("Rewarded Loaded ✅")

	is_rewarded_loaded = true

	reward_retries = 0

	admob.show_rewarded_ad()


func _on_rewarded_failed(ad_info, error):

	print("Rewarded Failed ❌ ", error.get_message())

	await get_tree().create_timer(retry_time).timeout

	load_rewarded()


# =========================
# PAUSE / RESUME
# =========================

func _on_ad_opened(ad_info):

	print("Ad Opened → Pause Game ⏸")

	get_tree().paused = true


func _on_interstitial_closed(ad_info):

	print("Interstitial Closed → Resume Game ▶")

	get_tree().paused = false


func _on_rewarded_closed(ad_info):

	print("Rewarded Closed → Resume Game ▶")

	get_tree().paused = false
