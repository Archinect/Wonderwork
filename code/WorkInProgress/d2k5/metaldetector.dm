/obj/machinery/metaldetector
	name = "metal detector"
	desc = "a metal detector. staff can toggle this between ignore security and detect all with their id."
	anchored = 1
	density = 0
	icon = 'icons/obj/metaldetector.dmi'
	icon_state = "metaldetector0"
	use_power = 1
	idle_power_usage = 20
	active_power_usage = 250
	var/guncount = 0
	var/knifecount = 0
	var/bombcount = 0
	var/meleecount = 0
	var/detectall = 0

/obj/machinery/metaldetector/check_access(obj/item/weapon/card/id/I, list/access_list)
	if(!istype(access_list))
		return 1
	if(!access_list.len) //no requirements
		return 1
	if(istype(I, /obj/item/device/pda))
		var/obj/item/device/pda/pda = I
		I = pda.id
	if(!istype(I) || !I.access) //not ID or no access
		return 0
	return 1

/obj/machinery/metaldetector/attackby(obj/item/W as obj, mob/user as mob)

	if(istype(W, /obj/item/weapon/card/emag))
		if(!src.emagged)
			src.emagged = 1
			user << "\blue You short out the circuitry."
			return
	if(istype(W, /obj/item/weapon/card))
		for(var/ID in list(user.equipped()))
			if(src.check_access(ID,list("20")))
				if(!src.detectall)
					src.detectall = 1
					user << "\blue You set the [src] to detect all personnel."
					return
				else
					src.detectall = 0
					user << "\blue You set the [src] to ignore all staff and security."
					return
			else
				user << "\red You lack access to the control panel!"
				return

/obj/machinery/metaldetector/HasEntered(AM as mob|obj)
	if(emagged)
		return
	if (istype(AM, /mob/living/carbon/human))
		var/mob/M =	AM
		if(!src.detectall)
			if(M:wear_id || M:belt)
				for(var/ID in list(M:equipped(), M:wear_id, M:belt))
					if(src.check_access(ID,list("1", "2", "3", "20", "57", "58")))
						return
		if (istype(M, /mob/living))
			for(var/obj/item/weapon/gun/G in M)
				guncount++
			for(var/obj/item/device/transfer_valve/B in M)
				bombcount++
			for(var/obj/item/weapon/kitchen/utensil/knife/K in M)
				knifecount++
			for(var/obj/item/weapon/kitchenknife/KK in M)
				knifecount++
			for(var/obj/item/weapon/plastique/KK in M)
				bombcount++
			for(var/obj/item/weapon/melee/ML in M)
				meleecount++
			if(guncount)
				flick("metaldetector2",src)
				playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
				for (var/mob/O in viewers(O, null))
					O << "\red <b>[src.name]</b> beeps, \"Alert! Firearm found on [M.name]!\""

				if(seen_by_camera(M))
					// determine the name of the perp (goes by ID if wearing one)
					var/perpname = M.name
					if(M:wear_id && M:wear_id.registered_name)
						perpname = M:wear_id.registered_name
					// find the matching security record
					for(var/datum/data/record/R in data_core.general)
						if(R.fields["name"] == perpname)
							for (var/datum/data/record/S in data_core.security)
								if (S.fields["id"] == R.fields["id"])
									// now add to rap sheet
									S.fields["criminal"] = "*Arrest*"
									S.fields["mi_crim"] = "Carrying a firearm."
									break

				guncount = 0
			else if(knifecount)
				flick("metaldetector2",src)
				playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
				for (var/mob/O in viewers(O, null))
					O << "\red <b>[src.name]</b> beeps, \"Alert! Knife found on [M.name]!\""

				if(seen_by_camera(M))
					// determine the name of the perp (goes by ID if wearing one)
					var/perpname = M.name
					if(M:wear_id && M:wear_id.registered_name)
						perpname = M:wear_id.registered_name
					// find the matching security record
					for(var/datum/data/record/R in data_core.general)
						if(R.fields["name"] == perpname)
							for (var/datum/data/record/S in data_core.security)
								if (S.fields["id"] == R.fields["id"])
									// now add to rap sheet
									S.fields["criminal"] = "*Arrest*"
									S.fields["mi_crim"] = "Carrying a knife."
									break

				knifecount = 0
			else if(bombcount)
				flick("metaldetector2",src)
				playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
				for (var/mob/O in viewers(O, null))
					O << "\red <b>[src.name]</b> beeps, \"Alert! Bomb found on [M.name]!\""

				if(seen_by_camera(M))
					// determine the name of the perp (goes by ID if wearing one)
					var/perpname = M.name
					if(M:wear_id && M:wear_id.registered_name)
						perpname = M:wear_id.registered_name
					// find the matching security record
					for(var/datum/data/record/R in data_core.general)
						if(R.fields["name"] == perpname)
							for (var/datum/data/record/S in data_core.security)
								if (S.fields["id"] == R.fields["id"])
									// now add to rap sheet
									S.fields["criminal"] = "*Arrest*"
									S.fields["mi_crim"] = "Carrying a bomb."
									break

				bombcount = 0
			else if(meleecount)
				flick("metaldetector2",src)
				playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
				for (var/mob/O in viewers(O, null))
					O << "\red <b>[src.name]</b> beeps, \"Alert! Melee weapon found on [M.name]!\""

				if(seen_by_camera(M))
					// determine the name of the perp (goes by ID if wearing one)
					var/perpname = M.name
					if(M:wear_id && M:wear_id.registered_name)
						perpname = M:wear_id.registered_name
					// find the matching security record
					for(var/datum/data/record/R in data_core.general)
						if(R.fields["name"] == perpname)
							for (var/datum/data/record/S in data_core.security)
								if (S.fields["id"] == R.fields["id"])
									// now add to rap sheet
									S.fields["criminal"] = "*Arrest*"
									S.fields["mi_crim"] = "Carrying a weapon."
									break

				meleecount = 0
			else
				flick("metaldetector1",src)

	else
		return

/obj/machinery/metaldetector/portable
	name = "Mr. V.A.L.I.D. Portable Threat Detector"
	desc = "This state of the art unit allows NT security personnel to contain a situation or secure an area better and faster."
	icon_state = "portdetector0"
	anchored = 0
	var/locked = 0

/obj/machinery/metaldetector/portable/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		if(locked)
			user << "The bolts are covered, unlocking this would retract the covers."
			return
		if(anchored)
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "\blue You unsecure the [src] from the floor!"
			anchored = 0
		else
			if(istype(get_turf(src), /turf/space)) return //No wrenching these in space!
			playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)
			user << "\blue You secure the [src] to the floor!"
			anchored = 1

	else if(istype(W, /obj/item/weapon/card/id) || istype(W, /obj/item/device/pda))
		if(src.allowed(user))
			src.locked = !src.locked
			user << "The controls are now [src.locked ? "locked." : "unlocked."]"
		else
			user << "\red Access denied."

	else
		..()