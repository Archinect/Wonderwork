//cleansed 9/15/2012 17:48

/*
CONTAINS:
MATCHES
CIGARETTES
CIGARS
SMOKING PIPES
CHEAP LIGHTERS
ZIPPO

CIGARETTE PACKETS ARE IN FANCY.DM
*/

///////////
//MATCHES//
///////////
/obj/item/weapon/match
	name = "match"
	desc = "A simple match stick, used for lighting fine smokables."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	var/lit = 0
	var/smoketime = 5
	w_class = 1.0
	origin_tech = "materials=1"
	attack_verb = list("burnt", "singed")

/obj/item/weapon/match/process()
	var/turf/location = get_turf(src)
	smoketime--
	if(smoketime < 1)
		icon_state = "match_burnt"
		lit = -1
		processing_objects.Remove(src)
		return
	if(location)
		location.hotspot_expose(700, 5)
		return

/obj/item/weapon/match/dropped(mob/user as mob)
	if(lit == 1)
		lit = -1
		damtype = "brute"
		icon_state = "match_burnt"
		item_state = "cigoff"
		name = "burnt match"
		desc = "A match. This one has seen better days."
	return ..()

//////////////////
//FINE SMOKABLES//
//////////////////
/obj/item/clothing/mask/cigarette
	name = "cigarette"
	desc = "A roll of tobacco and nicotine."
	icon_state = "cigoff"
	throw_speed = 0.5
	item_state = "cigoff"
	w_class = 1
	body_parts_covered = null
	attack_verb = list("burnt", "singed")
	var/lit = 0
	var/icon_on = "cigon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "cigoff"
	var/type_butt = /obj/item/weapon/cigbutt
	var/lastHolder = null
	var/smoketime = 300
	var/chem_volume = 15

/obj/item/clothing/mask/cigarette/New()
	..()
	flags |= NOREACT // so it doesn't react until you light it
	create_reagents(chem_volume) // making the cigarrete a chemical holder with a maximum volume of 15

/obj/item/clothing/mask/cigarette/Del()
	..()
	del(reagents)

/obj/item/clothing/mask/cigarette/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn())//Badasses dont get blinded while lighting their cig with a welding tool
			light("<span class='notice'>[user] casually lights the [name] with [W], what a badass.</span>")

	else if(istype(W, /obj/item/weapon/lighter/zippo))
		var/obj/item/weapon/lighter/zippo/Z = W
		if(Z.lit)
			light("<span class='rose'>With a single flick of their wrist, [user] smoothly lights their [name] with their [W]. Damn they're cool.</span>")

	else if(istype(W, /obj/item/weapon/lighter))
		var/obj/item/weapon/lighter/L = W
		if(L.lit)
			light("<span class='notice'>After some fiddling, [user] manages to light their [name] with [W].</span>")

	else if(istype(W, /obj/item/weapon/match))
		var/obj/item/weapon/match/M = W
		if(M.lit)
			light("<span class='notice'>[user] lights their [name] with their [W].</span>")

	else if(istype(W, /obj/item/weapon/melee/energy/sword))
		var/obj/item/weapon/melee/energy/sword/S = W
		if(S.active)
			light("<span class='warning'>[user] swings their [W], barely missing their nose. They light their [name] in the process.</span>")

	else if(istype(W, /obj/item/device/assembly/igniter))
		light("<span class='notice'>[user] fiddles with [W], and manages to light their [name].</span>")

	//can't think of any other way to update the overlays :<
	user.update_inv_wear_mask(0)
	user.update_inv_l_hand(0)
	user.update_inv_r_hand(1)
	return


/obj/item/clothing/mask/cigarette/afterattack(obj/item/weapon/reagent_containers/glass/glass, mob/user as mob)
	..()
	if(istype(glass))	//you can dip cigarettes into beakers
		var/transfered = glass.reagents.trans_to(src, chem_volume)
		if(transfered)	//if reagents were transfered, show the message
			user << "<span class='notice'>You dip \the [src] into \the [glass].</span>"
		else			//if not, either the beaker was empty, or the cigarette was full
			if(!glass.reagents.total_volume)
				user << "<span class='notice'>[glass] is empty.</span>"
			else
				user << "<span class='notice'>[src] is full.</span>"


/obj/item/clothing/mask/cigarette/proc/light(var/flavor_text = "[usr] lights the [name].")
	if(!src.lit)
		src.lit = 1
		damtype = "fire"
		if(reagents.get_reagent_amount("plasma")) // the plasma explodes when exposed to fire
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("plasma") / 2.5, 1), get_turf(src), 0, 0)
			e.start()
			del(src)
			return
		if(reagents.get_reagent_amount("fuel")) // the fuel explodes, too, but much less violently
			var/datum/effect/effect/system/reagents_explosion/e = new()
			e.set_up(round(reagents.get_reagent_amount("fuel") / 5, 1), get_turf(src), 0, 0)
			e.start()
			del(src)
			return
		flags &= ~NOREACT // allowing reagents to react after being lit
		reagents.handle_reactions()
		icon_state = icon_on
		item_state = icon_on
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
		processing_objects.Add(src)


/obj/item/clothing/mask/cigarette/process()
	var/turf/location = get_turf(src)
	smoketime--
	if(smoketime < 1)
		new type_butt(location)
		processing_objects.Remove(src)
		if(ismob(loc))
			var/mob/living/M = loc
			M << "<span class='notice'>Your [name] goes out.</span>"
			M.u_equip(src)	//un-equip it so the overlays can update
			M.update_inv_wear_mask(0)
		del(src)
		return
	if(location)
		location.hotspot_expose(700, 5)
	if(reagents && reagents.total_volume)	//	check if it has any reagents at all
		if(iscarbon(loc) && (src == loc:wear_mask)) // if it's in the human/monkey mouth, transfer reagents to the mob
			var/mob/living/carbon/C = loc
			if(prob(15)) // so it's not an instarape in case of acid
				reagents.reaction(C, INGEST)
			reagents.trans_to(C, REAGENTS_METABOLISM)
		else // else just remove some of the reagents
			reagents.remove_any(REAGENTS_METABOLISM)
	return


/obj/item/clothing/mask/cigarette/attack_self(mob/user as mob)
	if(lit == 1)
		user.visible_message("<span class='notice'>[user] calmly drops and treads on the lit [src], putting it out instantly.</span>")
		var/turf/T = get_turf(src)
		new type_butt(T)
		processing_objects.Remove(src)
		del(src)
	return ..()


///////////
// JOINT //
///////////
/obj/item/clothing/mask/cigarette/weed
	name = "joint"
	desc = "420 smoke weed errday."
	smoketime = 250
	chem_volume = 50
// See paper for creation

////////////
// CIGARS //
////////////
/obj/item/clothing/mask/cigarette/cigar
	name = "Premium Cigar"
	desc = "A brown roll of tobacco and... well, you're not quite sure. This thing's huge!"
	icon_state = "cigaroff"
	icon_on = "cigaron"
	icon_off = "cigaroff"
	type_butt = /obj/item/weapon/cigbutt/cigarbutt
	throw_speed = 0.5
	item_state = "cigaroff"
	smoketime = 1500
	chem_volume = 20

/obj/item/clothing/mask/cigarette/cigar/cohiba
	name = "Cohiba Robusto Cigar"
	desc = "There's little more you could want from a cigar."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"

/obj/item/clothing/mask/cigarette/cigar/havana
	name = "Premium Havanian Cigar"
	desc = "A cigar fit for only the best for the best."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 7200
	chem_volume = 30

/obj/item/weapon/cigbutt
	name = "cigarette butt"
	desc = "A manky old cigarette butt."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "cigbutt"
	w_class = 1
	throwforce = 1

/obj/item/weapon/cigbutt/cigarbutt
	name = "cigar butt"
	desc = "A manky old cigar butt."
	icon_state = "cigarbutt"


/obj/item/clothing/mask/cigarette/cigar/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/match))
		..()
	else
		user << "<span class='notice'>\The [src] straight out REFUSES to be lit by such uncivilized means.</span>"

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/clothing/mask/cigarette/pipe
	name = "smoking pipe"
	desc = "A pipe, for smoking. Probably made of meershaum or something."
	icon_state = "pipeoff"
	item_state = "pipeoff"
	icon_on = "pipeon"  //Note - these are in masks.dmi
	icon_off = "pipeoff"
	smoketime = 100

/obj/item/clothing/mask/cigarette/pipe/light(var/flavor_text = "[usr] lights the [name].")
	if(!src.lit)
		src.lit = 1
		damtype = "fire"
		icon_state = icon_on
		item_state = icon_on
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
		processing_objects.Add(src)

/obj/item/clothing/mask/cigarette/pipe/process()
	var/turf/location = get_turf(src)
	smoketime--
	if(smoketime < 1)
		new /obj/effect/decal/cleanable/ash(location)
		if(ismob(loc))
			var/mob/living/M = loc
			M << "<span class='notice'>Your [name] goes out, and you empty the ash.</span>"
			lit = 0
			icon_state = icon_off
			item_state = icon_off
			M.update_inv_wear_mask(0)
		processing_objects.Remove(src)
		return
	if(location)
		location.hotspot_expose(700, 5)
	return

/obj/item/clothing/mask/cigarette/pipe/attack_self(mob/user as mob) //Refills the pipe. Can be changed to an attackby later, if loose tobacco is added to vendors or something.
	if(lit == 1)
		user.visible_message("<span class='notice'>[user] puts out [src].</span>")
		lit = 0
		icon_state = icon_off
		item_state = icon_off
		processing_objects.Remove(src)
		return
	if(smoketime <= 0)
		user << "<span class='notice'>You refill the pipe with tobacco.</span>"
		smoketime = initial(smoketime)
	return

/obj/item/clothing/mask/cigarette/pipe/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/match))
		..()
	else
		user << "<span class='notice'>\The [src] straight out REFUSES to be lit by such means.</span>"

/obj/item/clothing/mask/cigarette/pipe/cobpipe
	name = "corn cob pipe"
	desc = "A nicotine delivery system popularized by folksy backwoodsmen and kept popular in the modern age and beyond by space hipsters."
	icon_state = "cobpipeoff"
	item_state = "cobpipeoff"
	icon_on = "cobpipeon"  //Note - these are in masks.dmi
	icon_off = "cobpipeoff"
	smoketime = 400



/////////
//ZIPPO//
/////////
/obj/item/weapon/lighter
	name = "cheap lighter"
	desc = "A cheap-as-free lighter."
	icon = 'icons/obj/items.dmi'
	icon_state = "lighter-g"
	item_state = "lighter-g"
	var/icon_on = "lighter-g-on"
	var/icon_off = "lighter-g"
	w_class = 1
	throwforce = 4
	flags = TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	attack_verb = list("burnt", "singed")
	var/lit = 0

/obj/item/weapon/lighter/zippo
	name = "Zippo lighter"
	desc = "The zippo."
	icon_state = "zippo"
	item_state = "zippo"
	icon_on = "zippoon"
	icon_off = "zippo"

/obj/item/weapon/lighter/random
	New()
		var/item_color = pick("r","c","y","g")
		icon_on = "lighter-[item_color]-on"
		icon_off = "lighter-[item_color]"
		icon_state = icon_off

/obj/item/weapon/lighter

	attack_self(mob/user)
		if(user.r_hand == src || user.l_hand == src)
			if(!src.lit)
				src.lit = 1
				src.icon_state = icon_on
				src.item_state = icon_on
				if( istype(src,/obj/item/weapon/lighter/zippo) )
					for(var/mob/O in viewers(user, null))
						O.show_message(text("\red Without even breaking stride, \the [] flips open and lights \the [] in one smooth movement.", user, src), 1)
				else
					if(prob(75))
						for(var/mob/O in viewers(user, null))
							O.show_message("\red After a few attempts, \the [user] manages to light \the [src].", 1)
					else
						user << "\red <b>You burn yourself while lighting the lighter.</b>"
						for(var/mob/O in viewers(user, null))
							O.show_message("\red After a few attempts, \the [user] manages to light \the [src], they however burn themself in the process.", 1)

				user.ul_SetLuminosity(user.LuminosityRed + 2, user.LuminosityGreen + 1, user.LuminosityBlue)
				processing_objects.Add(src)
			else
				src.lit = 0
				src.icon_state = icon_off
				src.item_state = icon_off
				if( istype(src,/obj/item/weapon/lighter/zippo) )
					for(var/mob/O in viewers(user, null))
						O.show_message(text("\red You hear a quiet click, as [] shuts off the [] without even looking at what they're doing. Wow.", user, src), 1)
				else
					for(var/mob/O in viewers(user, null))
						O.show_message("\red [user] quietly shuts off the [src].", 1)

				user.ul_SetLuminosity(user.LuminosityRed - 2, user.LuminosityGreen - 1, user.LuminosityBlue)
				processing_objects.Remove(src)
		else
			return ..()
		return


	attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
		if(!istype(M, /mob))
			return

		if(istype(M.wear_mask,/obj/item/clothing/mask/cigarette) && user.zone_sel.selecting == "mouth" && src.lit)
			if(M == user)
				M.wear_mask:light("\red With a single flick of their wrist, [user] smoothly lights their [M.wear_mask.name] with their [src.name]. Damn they're cool.")
			else
				M.wear_mask:light("\red [user] whips the [src.name] out and holds it for [M]. Their arm is as steady as the unflickering flame they light the [M.wear_mask.name] with.")
		else
			..()


	process()
		var/turf/location = get_turf(src)
		if(location)
			location.hotspot_expose(700, 5)
		return


	pickup(mob/user)
		if(lit)
			ul_SetLuminosity(0)
			user.ul_SetLuminosity(user.LuminosityRed + 2, user.LuminosityGreen + 1, user.LuminosityBlue)
		return


	dropped(mob/user)
		if(lit)
			user.ul_SetLuminosity(user.LuminosityRed - 2, user.LuminosityGreen - 1, user.LuminosityBlue)
			ul_SetLuminosity(2,1,0)
		return
