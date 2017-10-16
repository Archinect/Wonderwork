/obj/machinery/gramophone
	name = "Gramophone"
	desc = "Old-time styley."
	icon = 'icons/obj/musician.dmi'
	icon_state = "gramophone"
	layer = MOB_LAYER + 0.2
	anchored = 1
	density = 1
	var/playing = 0
	var/current_track = "sound/turntable/valz2.ogg"

/obj/machinery/gramophone/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/gramophone/attack_hand(mob/living/user as mob)

	if (src.playing == 0)
		user << "\blue You turn on the gramophone."
		StartPlaying()
	else
		user << "\blue You turn off the gramophone."
		StopPlaying()

/obj/machinery/gramophone/proc/StopPlaying()
	var/area/main_area = get_area(src)
	// Always kill the current sound
	for(var/mob/living/M in mobs_in_area(main_area))
		M << sound(null, channel = 1)

		main_area.forced_ambience = null
	playing = 0

/obj/machinery/gramophone/proc/StartPlaying()
	StopPlaying()
	if(!current_track)
		return

	var/area/main_area = get_area(src)
	main_area.forced_ambience = list(pick(current_track))
	for(var/mob/living/M in mobs_in_area(main_area))
		if(M.mind)
			main_area.play_ambience(M)

	playing = 1