/obj/machinery/metal_detector
	name = "metal detector"
	desc = "a metal detector. staff can toggle this between ignore security and detect all with their id."
	icon = 'icons/obj/metaldetector.dmi'
	icon_state = "metaldetector0"
	anchored = 0
	var/on = 0
	var/access
	var/locked = 0
	density = 0
	layer = 3
	req_access = list(access_security)



	var/ignore_access = 0 // It won't check persons who have security access

	var/check_firearm = 1
	var/check_bombs = 1
	var/check_knife = 1
	var/check_melee_weapon = 1

	var/guncount = 0
	var/knifecount = 0
	var/bombcount = 0
	var/meleecount = 0
	var/detectall = 0

/obj/machinery/metal_detector/power_change()
	if(powered())
		stat &= ~NOPOWER
		update_icon()
	else
		on = 0
		stat |= NOPOWER
		update_icon()

/obj/machinery/metal_detector/attackby(obj/item/weapon/W, mob/user)
	if(emagged)
		user << "<span class='warning'>ERROR</span>"
		return
	if(istype(W, /obj/item/weapon/card/id))
		user << "<span class='notice'>You conducted a card on cardreader.</span>"
		if(src.check_access(W,list("1", "2", "3", "20", "57", "58", "30", "56","40")))
			if(!access)
				access = 1
				for (var/mob/O in viewers(O, null))
					O << " <b>[src.name]</b> beeps, \"Access granted.\""
			else
				access = null
				for (var/mob/O in viewers(O, null))
					O << " <b>[src.name]</b> beeps, \"Access closed.\""
		else
			flick("metaldetector2",src)
			playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
			for (var/mob/O in viewers(O, null))
				O << " <b>[src.name]</b> beeps, \"Authorization failed.\""

	if(istype(W,/obj/item/weapon/wrench))
		user << "<span class='notice'>You begin [anchored ? "un" : ""]securing [name]...</span>"
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		if(do_after(user, 20))
			user << "<span class='notice'>You [anchored ? "un" : ""]secure [name].</span>"
			anchored = !anchored
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		return

	if(istype(W, /obj/item/weapon/card/emag))
		if(!emagged)
			emagged = 1
			playsound(loc, 'sound/effects/sparks4.ogg', 50, 1)
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(5, 1, src)
			s.start()
			desc += "<span class='warning'>It seems malfunctioning.</span>"
		return

/obj/machinery/metal_detector/attack_hand(mob/user as mob)
	if(stat & NOPOWER)
		usr << "<span class='warning'>The [src] seems unpowered.</span>"
		return
	if(!anchored)
		user << "<span class='warning'>It must be secured first!</span>"
		return
	if(emagged)
		user << "<span class='warning'>ERROR</span>"
		return

	interact(user)
	usr.set_machine(src)

/obj/machinery/metal_detector/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/metal_detector/interact(mob/user as mob)
	if(access)
		var/dat
		if(!locked)
			dat += text({"
				Status: <a href='?src=\ref[src];on=1'>[on ? "On" : "Off"]</a><br>
				Ignore access: <a href='?src=\ref[src];ignore_access=1'>[ignore_access ? "Yes" : "No"]</a><br>
				Check firearm: <a href='?src=\ref[src];check_firearm=1'>[check_firearm ? "Yes" : "No"]</a><br>
				Check bombs: <a href='?src=\ref[src];check_bombs=1'>[check_bombs ? "Yes" : "No"]</a><br>
				Check knife: <a href='?src=\ref[src];check_knife=1'>[check_knife ? "Yes" : "No"]</a><br>
				Check melee weapon: <a href='?src=\ref[src];check_melee_weapon=1'>[check_melee_weapon ? "Yes" : "No"]</a><br>
				</tt>"})

		var/datum/browser/popup = new(user, "metal_detector", "Security Metal Detector")
		popup.set_content(dat)
		popup.open()
		return
	else
		user << "<span class='notice'>You touch black display.</span>"
/obj/machinery/metal_detector/Topic(href, href_list)
	..()

	if(href_list["locked"] && allowed(usr))
		locked = !locked
	else if(href_list["on"])
		on = !on
		update_icon()
	else if(href_list["ignore_access"])
		ignore_access = !ignore_access
	else if(href_list["check_firearm"])
		check_firearm = !check_firearm
	else if(href_list["check_bombs"])
		check_bombs = !check_bombs
	else if(href_list["check_knife"])
		check_knife = !check_knife
	else if(href_list["check_melee_weapon"])
		check_melee_weapon = !check_melee_weapon

	updateUsrDialog()
	return

/obj/machinery/metal_detector/update_icon()
	if(anchored && on && !stat)
		icon_state = "metaldetector0"
/*
/obj/machinery/metal_detector/proc/try_detect_banned(obj/item/I) //meh
	if((check_guns && istype(I,/obj/item/weapon/gun)) || (check_grenades && istype(I,/obj/item/weapon/grenade)))
		icon_state = "metaldetector2"
		playsound(loc, 'sound/effects/alert.ogg', 50, 1)
		spawn(15)
			update_icon()
			return 1
	else return 0

/obj/machinery/metal_detector/Crossed(var/mob/living/carbon/M)


		if((M && ignore_access && !allowed(M)) || (M && !ignore_access))
			for(var/obj/item/O in M.contents)
				if(istype(O, /obj/item/weapon/storage))
					var/obj/item/weapon/storage/S = O
					for(var/obj/item/I in S.contents)
						if(try_detect_banned(I))
							return
				else
					if(try_detect_banned(O))
						return
*/

/obj/machinery/metal_detector/check_access(obj/item/weapon/card/id/I, list/access_list)
	if(!istype(access_list))
		return 1
	if(!access_list.len) //no requirements
		return 1
	if(istype(I, /obj/item/device/pda))
		var/obj/item/device/pda/pda = I
		I = pda.id
	if(!istype(I) || !I.access) //not ID or no access
		return 0

/obj/machinery/metal_detector/Crossed(var/mob/living/carbon/M)
	if(anchored && on)
		if(emagged)
			electrocute_mob(M, get_area(src), src)
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(5, 1, src)
			s.start()
			playsound(loc, 'sound/machines/ping.ogg', 100, 0)
			return
		if (istype(M, /mob/living/carbon/human))
			var/contents = M.contents
			for(var/obj/item/O in M.contents)
				if(istype(O, /obj/item/weapon/storage))
					contents = M.contents + O.contents
			for(var/ID in list(M.equipped(), M:wear_id, M:belt))
				if(src.check_access(ID,list("1", "2", "3", "20", "57", "58", "30", "56","40")))
					return
				if(check_firearm)
					for(var/obj/item/weapon/gun/G in contents)
						guncount++
				if(check_bombs)
					for(var/obj/item/device/transfer_valve/B in contents)
						bombcount++
				if(check_knife)
					for(var/obj/item/weapon/kitchen/utensil/knife/K in contents)
						knifecount++
				if(check_knife)
					for(var/obj/item/weapon/kitchenknife/KK in contents)
						knifecount++
				if(check_bombs)
					for(var/obj/item/weapon/plastique/KK in contents)
						bombcount++
				if(check_melee_weapon)
					for(var/obj/item/weapon/melee/ML in contents)
						meleecount++
				if(guncount)
					flick("metaldetector2",src)
					playsound(src.loc, 'sound/machines/ping.ogg', 60, 0)
					for (var/mob/O in viewers(O, null))
						O << "\red <b>[src.name]</b> beeps, \"Alert! Firearm found on [M.name]!\""

					if(seen_by_camera(M))
						// determine the name of the perp (goes by ID if wearing one)
						var/perpname = M.name
						if(M:wear_id && M:wear_id:registered_name)
							perpname = M:wear_id:registered_name
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
						if(M:wear_id && M:wear_id:registered_name)
							perpname = M:wear_id:registered_name
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
						if(M:wear_id && M:wear_id:registered_name)
							perpname = M:wear_id:registered_name
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
						if(M:wear_id && M:wear_id:registered_name)
							perpname = M:wear_id:registered_name
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
			return