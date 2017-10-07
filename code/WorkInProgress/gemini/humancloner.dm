/obj/machinery/humancloner
	name = "T-A remote human cloner"
	icon = 'icons/obj/cloning.dmi'
	icon_state = "hc_0"
	density = 1
	anchored = 1
	light_color = LIGHT_COLOR_BLUE
	light_power_on = 1
	light_range_on = 3
	var/cloning = 0

/obj/machinery/humancloner/New()
	sleep(4)
	set_light(3)

/obj/machinery/humancloner/power_change()
	if ( powered() )
		stat &= ~NOPOWER
		src.set_light(3)
	else
		stat |= ~NOPOWER
		src.set_light(0)

/obj/machinery/humancloner/attack_hand()
	if(!cloning)
		cloning = 150
		icon_state = "hc_g"

/obj/machinery/humancloner/attackby(var/obj/item/O as obj, var/mob/user as mob, params)
	if(istype(O, /obj/item/weapon/wrench))
		if(!anchored && istype(get_turf(src), /turf/space))
			anchored = 1
			//power_change()
			user << "<span class='notice'>You fasten [src].</span>"
		else if(anchored)
			anchored = 0
			//power_change()
			user << "<span class='notice'>You unfasten [src].</span>"
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)

/obj/machinery/humancloner/process()
	if(stat & (NOPOWER|BROKEN))
		return
	use_power(1000)
	if(cloning)
		cloning -= 1
		if(!cloning)
			new /mob/living/carbon/monkey(src.loc)  //need insert infant here
			icon_state = "hc_0"
	return