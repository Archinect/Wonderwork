
/obj/item/weapon/liquidcartridge
	icon = 'icons/obj/adv_stock_parts.dmi'
	name = "chem cartridge"
	icon_state = "cartridge"
	w_class = 3.0
	var/volume = 100

/obj/item/weapon/liquidcartridge/New()
	var/datum/reagents/R = new/datum/reagents(volume)
	reagents = R
	R.my_atom = src

	pixel_x = rand(0,12)-6
	pixel_y = rand(0,12)-6

/obj/item/weapon/tank/plasma/gascartridge
	icon = 'icons/obj/tank.dmi'
	name = "plasma cartridge"
	icon_state = "plasma_s"
	item_state = "	plasma-c"
	w_class = 3.0
	volume = 45
	pressure_resistance = ONE_ATMOSPHERE*2.5
	force = 5.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 4

/obj/item/weapon/tank/plasma/gascartridge/New()
	src.air_contents = new /datum/gas_mixture()
	src.air_contents.volume = volume //liters
	src.air_contents.temperature = T20C

	src.air_contents.toxins = (3*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C)

	pixel_x = rand(0,8)-4
	pixel_y = rand(0,8)-4

/obj/effect/deployhologram
	name = "content preview"
	layer = MOB_LAYER + 1
	mouse_opacity = 0
	anchored = 1

/obj/item/weapon/deployframe
	icon = 'icons/obj/adv_stock_parts.dmi'
	name = "deployment frame"
	icon_state = "deploy0"
	w_class = 4.0
	var/list/deploytypes = list()
	var/deploydir = 2
	var/ready = 0
	var/obj/effect/deployhologram/currentholo

/obj/item/weapon/deployframe/New()
	..()

	pixel_x = rand(0,8)-4
	pixel_y = rand(0,8)-4

	processing_objects.Add(src)

/obj/item/weapon/deployframe/Del()
	processing_objects.Remove(src)

/obj/item/weapon/deployframe/attackby(obj/item/item, mob/user)
	if(istype(item, /obj/item/weapon/wrench))
		if(ready)
			user << "\blue You deploy the frame. It's contents expand!"
			deploy()
		else
			user << "\blue You prepare the deployframe. Use a screwdiver to rotate the frame. Crowbar to pick it up."

			user.before_take_item(src)
			loc = get_turf(user)
			ready()

	else if(istype(item, /obj/item/weapon/screwdriver))
		if(ready)
			deploydir = turn(deploydir, 90)
			makehologram()
			icon_state = "deploy[deploydir]"

	else if(istype(item, /obj/item/weapon/crowbar))
		if(ready)
			unready()

/obj/item/weapon/deployframe/proc/ready()
	icon_state = "deploy[deploydir]"
	ready = 1
	anchored = 1
	makehologram()

/obj/item/weapon/deployframe/proc/makehologram()
	if(!currentholo) currentholo = new(loc)

	var/icon/newicon

	for(var/typepath in deploytypes)
		var/obj/O = new typepath(src)

		if(!O)
			continue

		if(!newicon) newicon = icon(O.icon, O.icon_state, O.dir, 1)
		else newicon.Blend(icon(O.icon, O.icon_state, O.dir, 1), ICON_OVERLAY)

		currentholo.pixel_x = O.pixel_x
		currentholo.pixel_y = O.pixel_y

		del(O)

	currentholo.icon = getHologramIcon(newicon, 1, rgb(20,240,60))

/obj/item/weapon/deployframe/process()
	if(currentholo)
		currentholo.loc = get_turf(src)

/obj/item/weapon/deployframe/proc/unready()
	icon_state = "deploy0"
	ready = 0
	anchored = 0
	if(currentholo)
		del(currentholo)
		currentholo = null

/obj/item/weapon/deployframe/proc/deploy()
	for(var/typepath in deploytypes)
		var/obj/O = new typepath(src.loc)
		if(O)
			O.dir = deploydir

	del(src)

/obj/item/weapon/deployframe/Del()
	if(currentholo)
		del(currentholo)
	..()

/obj/item/weapon/blueprintdisk
	icon = 'icons/obj/adv_stock_parts.dmi'
	name = "blueprint disk"
	icon_state = "bluedisk"
	w_class = 2.0
	var/list/recipes = list()
	var/list/researches = list()
	var/researchlevel = 0

///obj/item/weapon/blueprintdisk/robots
	//New()
	//	..()
	//	for(var/datum/assemblerprint/recipe in assembler_recipes)
	//		recipes += recipe

/obj/item/weapon/blueprintdisk/New()
	..()

	for(var/datum/assemblerprint/recipe in assembler_recipes)
		//world << "[recipe.name]: [recipe.tech] in researches [recipe.tech in researches] - [recipe.simplicity] [recipe.simplicity >= max(0,100-researchlevel)]"

		if((!researches.len || !recipe.tech || (recipe.tech in researches)) && (recipe.simplicity >= max(0,100-researchlevel)))
			//world << "added."
			src.recipes += recipe

	pixel_x = rand(0,12)-6
	pixel_y = rand(0,12)-6

/obj/item/weapon/blueprintdisk/robotics
	name = "robotics blueprint disk"
	researches = list("robotics")

/obj/item/weapon/blueprintdisk/engineering
	name = "engineering blueprint disk"
	researches = list("engineering")

/obj/item/weapon/blueprintdisk/medical
	name = "medical blueprint disk"
	researches = list("medical")

/obj/item/weapon/blueprintdisk/civilian
	name = "civilian blueprint disk"
	researches = list("civilian")

/obj/item/weapon/blueprintdisk/clothing
	name = "clothing blueprint disk"
	researches = list("clothing")

/obj/item/weapon/blueprintdisk/mining
	name = "mining blueprint disk"
	researches = list("mining")

/obj/item/weapon/blueprintdisk/security
	name = "security blueprint disk"
	researches = list("security")

/obj/item/weapon/blueprintdisk/botany
	name = "botany blueprint disk"
	researches = list("botany")

/obj/item/weapon/blueprintdisk/omni
	name = "completed research disk"
	//researches = list("","civilian","robotics","engineering","medical","mining","security","clothing","security","botany")
	researches = list()
	researchlevel = 100

///obj/item/weapon/blueprintdisk/omni/New()
//	..()
//	for(var/datum/assemblerprint/recipe in assembler_recipes)
//		recipes += recipe


/obj/item/weapon/metaldetector
	icon = 'icons/obj/adv_stock_parts.dmi'
	name = "metaldetector frame"
	icon_state = "deploy0"
	w_class = 4.0

	attack_self(mob/user)
		var/obj/machinery/metal_detector/M = new /obj/machinery/metal_detector(user.loc)
		M.add_fingerprint(user)
		del(src)