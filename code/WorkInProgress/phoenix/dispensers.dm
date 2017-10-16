/obj/machinery/despenser/coffin
	name = "Coffin Despenser"
	icon = 'icons/obj/dispenser.dmi'
	desc = "A Coffin despenser it can be refilled by adding wood!"
	icon_state = "cd0"
	anchored = 1
	density = 0
	var/numofcoffins = 0


/obj/machinery/despenser/coffin/New()
	numofcoffins = 6
	icon_state = "cdf"
	update_icon()

/obj/machinery/despenser/coffin/update_icon()
	icon_state ="cd[numofcoffins]"

/obj/machinery/despenser/coffin/attack_hand(mob/user as mob)
	dispensecoffin()
/obj/machinery/despenser/coffin/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return

/obj/machinery/despenser/coffin/proc/dispensecoffin()
	for(var/obj/structure/closet/coffin/C in src.loc.contents)
		usr << "\red Cannot despense due to a coffin in despensing area."
		return
	if(numofcoffins == 0)
		usr << "\red Out of Coffins please refill despenser with wood."
		return
	if(numofcoffins >= 1)
		var/obj/structure/closet/coffin/D = new /obj/structure/closet/coffin(src.loc)
		D.opened = 1
		D.density = 0
		D.update_icon()
		numofcoffins--
		update_icon()
		return

/obj/machinery/despenser/coffin/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/stack/sheet/wood))
		var/obj/item/stack/sheet/wood/D = W
		if(src.numofcoffins >=6)
			user << "\red The [src] is full."
			return
		if(D.amount >=5)
			D.use(5)
			numofcoffins++
			update_icon()
			user << "\blue You add enough wood for one coffin to the despenser."
		else
			user << "\red not enough Wood you need 5 sheets per coffin."
			return

//ROLLERBED//

/obj/machinery/despenser/rollerbed
	name = "Rollerbed Despenser"
	icon = 'icons/obj/dispenser.dmi'
	desc = "A rollerbed despenser!"
	icon_state = "rbd0"
	anchored = 1
	density = 0
	var/numofRB = 0


/obj/machinery/despenser/rollerbed/New()
	numofRB = 8
	icon_state = "rbd8"
	update_icon()

/obj/machinery/despenser/rollerbed/update_icon()
	icon_state ="rbd[numofRB]"

/obj/machinery/despenser/rollerbed/attack_hand(mob/user as mob)
	dispenseRB()

/obj/machinery/despenser/rollerbed/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return

/obj/machinery/despenser/rollerbed/proc/dispenseRB()
	for(var/obj/structure/stool/bed/roller/C in src.loc.contents)
		usr << "\red Cannot despense due to a rollerbed in despensing area."
		return
	if(numofRB == 0)
		usr << "\red Out of Rollerbeds please refill."
		return
	if(numofRB >= 1)
		new /obj/structure/stool/bed/roller(src.loc)
		numofRB--
		update_icon()
		return

/obj/machinery/despenser/rollerbed/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/roller))
		var/obj/item/roller/D = W
		if(src.numofRB >=8)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofRB++
			update_icon()
			user << "\blue You add a rollerbed to the despenser."


/obj/machinery/despenser/metaldetector
	name = "Metaldetector Despenser"
	icon = 'icons/obj/dispenser.dmi'
	desc = "A metaldetector despenser!"
	icon_state = "wcd0"
	anchored = 1
	density = 0
	var/numofWC = 0


/obj/machinery/despenser/metaldetector/New()
	numofWC = 6
	icon_state = "wcd6"
	update_icon()

/obj/machinery/despenser/metaldetector/update_icon()
	icon_state ="wcd[numofWC]"

/obj/machinery/despenser/metaldetector/attack_hand(mob/user as mob)
	dispenseWC()

/obj/machinery/despenser/metaldetector/attack_robot(mob/user as mob)
	if(Adjacent(user))
		return src.attack_hand(user)
	else
		user << "<span class = \"warning\">You attempt to interface with the control circuits but find they are not connected to your network.  Maybe in a future firmware update.</span>"
	return

/obj/machinery/despenser/metaldetector/proc/dispenseWC()
	for(var/obj/item/weapon/metaldetector/C in src.loc.contents)
		usr << "\red Cannot despense due to a Metaldetector in despensing area."
		return
	if(numofWC == 0)
		usr << "\red Out of Wheelchairs please refill."
		return
	if(numofWC >= 1)
		new /obj/item/weapon/metaldetector(src.loc)
		numofWC--
		update_icon()
		return

/obj/machinery/despenser/metaldetector/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/metaldetector))
		var/obj/item/weapon/metaldetector/D = W
		if(src.numofWC >=6)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofWC++
			update_icon()
			user << "\blue You add a metaldetector to the despenser."


/obj/machinery/despenser/bodybag
	name = "Bodybag Despenser"
	icon = 'icons/obj/dispenser.dmi'
	desc = "A bodybag despenser!"
	icon_state = "bbd0"
	anchored = 1
	density = 0
	var/numofBB = 0


/obj/machinery/despenser/bodybag/New()
	numofBB = 8
	icon_state = "bbd8"
	update_icon()

/obj/machinery/despenser/bodybag/update_icon()
	icon_state ="bbd[numofBB]"

/obj/machinery/despenser/bodybag/attack_hand(mob/user as mob)
	dispenseBB()

/obj/machinery/despenser/bodybag/proc/dispenseBB()
	if(numofBB == 0)
		usr << "\red Out of Bodybags please refill."
		return
	if(numofBB >= 1)
		new /obj/item/bodybag(src.loc)
		numofBB--
		update_icon()
		return

/obj/machinery/despenser/bodybag/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/bodybag))
		var/obj/item/bodybag/D = W
		if(src.numofBB >=8)
			user << "\red The [src] is full."
			return
		else
			del(D)
			numofBB++
			update_icon()
			user << "\blue You add a bodybag to the despenser."

