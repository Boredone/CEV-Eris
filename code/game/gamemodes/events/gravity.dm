/*
	Very simple event that temporarily disables gravity all over the ship. Quite fun, but can also lead to people getting stuck
	This event used to contain some bullshit about forming black holes. No code provision exists for any such thing, so that is removed
*/

/datum/storyevent/gravity
	id = "gravity_failure"
	name = "gravity failure"

	event_type =/datum/event/gravity
	event_pools = list(EVENT_LEVEL_MUNDANE = POOL_THRESHOLD_MUNDANE*0.8)
	tags = list(TAG_COMMUNAL)
	weight = 0.4 //This is a pain, make it less common


/////////////////////////////////////////////////////////////

/datum/event/gravity
	announceWhen = 5

/datum/event/gravity/setup()
	endWhen = rand(30, 200) //1-6 minutes

/datum/event/gravity/announce()
	command_announcement.Announce("Feedback surge detected in mass-distributions systems. Artificial gravity has been disabled whilst the system reinitializes.", "Gravity Failure")

/datum/event/gravity/start()
	gravity_is_on = 0
	for(var/area/A in world)
		if(isStationLevel(A.z))
			A.gravitychange(gravity_is_on, A)

/datum/event/gravity/end()
	if(!gravity_is_on)
		gravity_is_on = 1

		for(var/area/A in world)
			if(isStationLevel(A.z))
				A.gravitychange(gravity_is_on, A)

		command_announcement.Announce("Gravity generators are again functioning within normal parameters. Sorry for any inconvenience.", "Gravity Restored")
