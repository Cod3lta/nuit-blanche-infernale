extends Node3D

@export var nb_levels: int = 3
@export var level_duration: int = 15

var level: int = 1
var events_queue: Array[Node] = []
# The order is important!
@onready var events: Array[Node] = [
	$Events/HungryEvent,
	$Events/ThirstyEvent,
	$Events/FireEvent,
]

#var level_timeouts: Array[int] = [ 25, 20, 15, 12, 10 ]
var level_timeouts: Array[int] = [ 3, 2, 1 ]

@onready var events_timer: Timer = $EventTimer
@onready var level_timer: Timer = $LevelTimer
@onready var game_timer: Timer = $GameTimer

func _ready():
	play_event()
	game_timer.start(nb_levels * level_duration)
	level_timer.start(level_duration)
	events_timer.start(get_event_wait_time())

# Returns the wait time between events based on the current level
func get_event_wait_time() -> int:
	return level_timeouts[level - 1]


func get_random_event() -> Node:
	var i: int = randi_range(0, level - 1)
	return events[i]


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
	print("level up")
	events_queue.push_back(events[level - 1])


func _on_game_timer_timeout():
	print("Game finished !!")
	events_timer.stop()
	level_timer.stop()
	game_timer.stop()
