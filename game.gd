extends Node3D

var game_started: bool = false

#@export var music_event: EventAsset
#var music_instance: EventInstance


var level_duration: int = 20		# The duration of each level
var current_level: int = 1
var events_queue: Array[Node] = []
# from 0 to 1, where 1 means the game is finished (6:00AM)
var game_progression: float = 0
# 1 = full life, 0 = dead
var health_bar: float = 1

signal music_progressed(progression: float)

# The last dict of each level always happens first when leveling up 
@onready var levels = [
	[
		{"node": $Events/HungryEvent, "occurence": 1},
	],
	[
		{"node": $Events/HungryEvent, "occurence": 0.9},
		{"node": $Events/ThirstyEvent, "occurence": 0.1},
	],
	[
		{"node": $Events/HungryEvent, "occurence": 0.8},
		{"node": $Events/ThirstyEvent, "occurence": 0.2},
	],
	[
		{"node": $Events/HungryEvent, "occurence": 0.45},
		{"node": $Events/ThirstyEvent, "occurence": 0.1},
		{"node": $Events/ToiletEvent, "occurence": 0.15},
		{"node": $Events/ToiletEvent2, "occurence": 0.15},
		{"node": $Events/ToiletEvent3, "occurence": 0.15},
	],
	[
		{"node": $Events/HungryEvent, "occurence": 0.4},
		{"node": $Events/ThirstyEvent, "occurence": 0.1},
		{"node": $Events/ToiletEvent, "occurence": 0.1},
		{"node": $Events/ToiletEvent2, "occurence": 0.1},
		{"node": $Events/ToiletEvent3, "occurence": 0.1},
		{"node": $Events/FireEvent, "occurence": 0.2},
	],
]

var level_timeouts: Array[int] = [ 7, 7, 5, 3, 2 ]

@onready var events_timer: Timer = $EventTimer
@onready var level_timer: Timer = $LevelTimer
@onready var game_timer: Timer = $GameTimer

func _ready():
	randomize()
	
	var nb_levels:int = levels.size()
	game_timer.start(nb_levels * level_duration)
	level_timer.start(level_duration)
	events_timer.start(get_event_wait_time())
	
	# Set the game timer
	game_timer.set_wait_time(nb_levels * level_duration)
	
	# Play the music
	#music_instance = FMODRuntime.create_instance(music_event)
	#music_instance.set_parameter_by_name("intensity", 1, false)
	#music_instance.start()


func _process(delta):
	# Set the music progression
	var nb_levels = levels.size()
	var progression = (current_level * level_duration + (1 - level_timer.time_left)) / (nb_levels * level_duration)
	progression *= nb_levels - 1
	progression += 1
	#music_instance.set_parameter_by_name("intensity", progression, false)
	emit_signal("music_progressed", progression)

# Returns the wait time between events based on the current level
func get_event_wait_time() -> int:
	return level_timeouts[current_level - 1]


func get_random_event() -> Node:
	var available_events = levels[current_level - 1]
	# Get a random float
	var prob_total = 0.0
	for available_event in available_events:
		prob_total += available_event['occurence']
	var i = randf_range(0, prob_total)
	# Get the event corresponding to that float
	var j = 0.0
	for available_event in available_events:
		if i > j and i < j + available_event['occurence']:
			# Return choosen event
			return available_event['node']
		else:
			j += available_event['occurence']
	print("ERROR: random event doesn't exist")
	return available_events[0]['node']
	


func play_event() -> void:
	var event: Node
	if events_queue.size() > 0:
		event = events_queue.pop_front()
	else:
		event = get_random_event()
	if event.has_method("start_event"):
		print(event)
		event.start_event()

func _on_event_timer_timeout():
	play_event()
	events_timer.start(get_event_wait_time())


func _on_level_timer_timeout():
	current_level += 1
	print("level up, now at ", current_level)
	var events_new_level: Array = levels[current_level - 1]
	var new_event_type = events_new_level.back()
	events_queue.push_back(new_event_type['node'])


func _on_game_timer_timeout():
	print("Events finished !!")
	events_timer.stop()
	level_timer.stop()
	game_timer.stop()


func _on_timer_before_start_timeout():
	# start_game()
	game_started = true
