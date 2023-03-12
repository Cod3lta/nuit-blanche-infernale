extends Node3D

var game_started: bool = false

@export var music_event: EventAsset
var music_instance: EventInstance

var level_duration: int = 30
var level: int = 1
var events_queue: Array[Node] = []
# The order is important!
@onready var events = [
	[$Events/HungryEvent],
	[$Events/ThirstyEvent],
	[$Events/ThirstyEvent],
	[
		$Events/ToiletEvent,
		$Events/ToiletEvent2,
		$Events/ToiletEvent3,
	],
	[$Events/FireEvent],
]

#var level_timeouts: Array[int] = [ 25, 20, 15, 12, 10 ]
var level_timeouts: Array[int] = [ 10, 9, 8, 7, 7 ]

@onready var events_timer: Timer = $EventTimer
@onready var level_timer: Timer = $LevelTimer
@onready var game_timer: Timer = $GameTimer

func _ready():
	randomize()
	
	var nb_levels:int = events.size()
	game_timer.start(nb_levels * level_duration)
	level_timer.start(level_duration)
	events_timer.start(get_event_wait_time())
	
	# Play the music
	music_instance = RuntimeManager.create_instance(music_event)
	music_instance.set_parameter_by_name("intensity", 1, false)
	music_instance.start()


func _process(delta):
	# Set the music progression
	var nb_levels = events.size()
	var progression = (level * level_duration + (1 - level_timer.time_left)) / (nb_levels * level_duration)
	progression *= nb_levels - 1
	progression += 1
	music_instance.set_parameter_by_name("intensity", progression, false)

# Returns the wait time between events based on the current level
func get_event_wait_time() -> int:
	return level_timeouts[level - 1]


func get_random_event() -> Node:
	var i: int = randi_range(0, level - 1)
	var event_of_same_type = events[i]
	return event_of_same_type[randi() % event_of_same_type.size()]


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
	level += 1
	print("level up, now at ", level)
	var event_of_same_type = events[level - 1]
	var new_event_available = event_of_same_type[randi() % event_of_same_type.size()]
	events_queue.push_back(new_event_available)


func _on_game_timer_timeout():
	print("Game finished !!")
	events_timer.stop()
	level_timer.stop()
	game_timer.stop()


func _on_timer_before_start_timeout():
	# start_game()
	game_started = true
