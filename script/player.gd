extends CharacterBody2D

<<<<<<< Updated upstream
const SPEED = 130.0
const DASH_SPEED = 300.0  # Faster speed when dashing
const JUMP_VELOCITY = -300.0
const DASH_DURATION = 0.2  # Dash lasts for 0.2 seconds
const DASH_COOLDOWN = 0.5  # Cooldown before dashing again
=======
const SPEED = 300.0
const DASH_SPEED = 500.0  # Faster speed when dashing
const JUMP_VELOCITY = -500.0
const DASH_DURATION = 0.3  # Dash lasts for 0.2 seconds
const DASH_COOLDOWN = 0.7  # Cooldown before dashing again
>>>>>>> Stashed changes

@onready var animated_sprite = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
<<<<<<< Updated upstream
=======
@onready var dash_particles = $dash_particles

@onready var cube = $cube
@onready var hollow = $hollow
@onready var able_to_lucid = false

@export var foot_step: PackedScene
@export var dash_object: PackedScene

#Audio Streams
@onready var dash_sfx: AudioStreamPlayer2D = $PlayerSfx/DashSfx
@onready var footstep_sfx: AudioStreamPlayer2D = $PlayerSfx/FootstepSfx
var was_in_air = false  # Track previous frame state

func _ready() -> void:
	Signals.start_lucidity.connect(
		func():
			able_to_lucid = true
	)
	NightTimer.timeout.connect(
		func(): 
			is_nightmare = true
			get_tree().create_timer(15).timeout.connect(
				func():
					get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
			)
	)

var is_lucid = false  # Flag to indicate if the player is in "lucid" mode
var is_nightmare = false
>>>>>>> Stashed changes

func _physics_process(delta) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction
	var direction := Input.get_axis("move_left", "move_right")

	# Handle dashing
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0 and direction != 0:
		is_dashing = true
<<<<<<< Updated upstream
		dash_timer = DASH_DURATION
		dash_cooldown_timer = DASH_COOLDOWN
=======
		animated_sprite.play("dash")
		dash_sfx.play()
		dash_timer = DASH_DURATION
		dash_cooldown_timer = DASH_COOLDOWN
	if is_dashing:
		var dash_node = dash_object.instantiate()
		dash_node.texture = animated_sprite.sprite_frames.get_frame_texture(animated_sprite.animation, animated_sprite.frame)
		dash_node.global_position = global_position
		dash_node.flip_h = animated_sprite.flip_h
		dash_node.scale = animated_sprite.scale # Preserve the scale
		get_parent().add_child(dash_node)
		
		dash_particles.emitting = true
	else:
		dash_particles.emitting = false
>>>>>>> Stashed changes

	# Dash logic
	if is_dashing:
		velocity.x = direction * DASH_SPEED
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false  # Stop dashing
	else:
		if direction:
			velocity.x = direction * SPEED
<<<<<<< Updated upstream
			animated_sprite.flip_h = direction < 0 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
=======
			animated_sprite.flip_h = direction < 0
			if is_nightmare:
				animated_sprite.animation = "run_nightmare"  # Play run animation
			else:
				animated_sprite.animation = "run"
			running_audio()  # Play run animation
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_nightmare:
				animated_sprite.animation = "idle_nightmare"  # Play run animation
			else:
				animated_sprite.animation = "idle"  # Play run animation
	# Detect Landing Sound
	if was_in_air and is_on_floor():  
		footstep_sfx.play()  # Play the landing sound when touching the ground

	# Update previous state
	was_in_air = not is_on_floor()

	# Jump and Fall logic
	if not is_on_floor():
		if velocity.y < 0 and not is_dashing:
			animated_sprite.animation = "jump"  # Play jump animation while rising
		elif velocity.y > 0 and not is_dashing:
			animated_sprite.animation = "fall"  # Play fall animation while falling
	elif not is_nightmare:
		# Handle landing (optional, can be added for a landing animation)
		if velocity.x == 0 and not is_dashing:
			animated_sprite.animation = "idle"  # Set idle animation when standing still on the floor
		elif not is_dashing:
			animated_sprite.animation = "run"  # Play run animation when moving
>>>>>>> Stashed changes

	# Reduce cooldown timer
	dash_cooldown_timer -= delta

	move_and_slide()
<<<<<<< Updated upstream
=======

func handle_player_particles():
	if(motion.x == 0):
		last_step = -1
	if(animated_sprite.animation == "run"):
		var footstep = foot_step.instantiate()


# Check for X key press to toggle lucid mode
func _process(delta) -> void:
	if Input.is_action_just_pressed("lucid") and not is_nightmare and able_to_lucid:
		is_lucid = not is_lucid  # Toggle lucid state
		Soundtrack.stream.set_sync_stream_volume(5,1)
		Soundtrack.stream.set_sync_stream_volume(6,1)
		if is_lucid:
			able_to_lucid = false
			animated_sprite.animation = "lucid"  # Switch to lucid animation
			hollow.visible = false
			cube.visible = true
			velocity = Vector2.ZERO
			get_tree().create_timer(10).timeout.connect(
				func():
					is_lucid = false
					Signals.end_lucidity.emit()
			)  # Stop all movement
		else:
			# If exiting lucid mode, restore normal movement and animation
			animated_sprite.animation = "idle"  # Or "run" if you want to default back to running animation
			hollow.visible = true
			cube.visible = false
			
			
	if Input.is_action_just_pressed("nightmare") and not is_lucid:
		is_nightmare = not is_nightmare  # Toggle nightmare state
		Soundtrack.stream.set_sync_stream_volume(3, NightTimer.time_left * -1)
		Soundtrack.stream.set_sync_stream_volume(4, NightTimer.time_left * -1)
		if is_nightmare:
			animated_sprite.animation = "idle_nightmare"  # Switch to nightmare animation
			hollow.visible = false
			cube.visible = false
			velocity *= 0.5  # 
		else:
			# If exiting nightmare mode, restore normal movement and animation
			animated_sprite.animation = "idle"  # Or "run" if you want to default back to running animation
			hollow.visible = false
			cube.visible = false
			velocity *= 2  #
			

func running_audio():
	var current_frame = animated_sprite.frame
	if current_frame == 2 or current_frame == 5: 
		footstep_sfx.play()
>>>>>>> Stashed changes
