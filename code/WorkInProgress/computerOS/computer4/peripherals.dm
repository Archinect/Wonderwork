/obj/item/weapon/peripheral
	name = "Peripheral card"
	desc = "A computer circuit board."
	icon = 'module.dmi'
	icon_state = "id_mod"
	item_state = "electronic"
	w_class = 2
	var/obj/machinery/computer2/host
	var/id = null

	New()
		..()
		spawn(2)
			if(istype(src.loc,/obj/machinery/computer2))
				host = src.loc
				host.peripherals.Add(src)
//			var/setup_id = "\ref[src]"
//			src.id = copytext(setup_id,4,(length(setup_id)-1) )

	Del()
		if(host)
			host.peripherals.Remove(src)
		..()


	proc
		receive_command(obj/source, command, datum/signal/signal)
			if((source != host) || !(src in host))
				return 1

			if(!command)
				return 1

			return 0

		send_command(command, datum/signal/signal)
			if(!command || !host)
				return

			src.host.receive_command(src, command, signal)

			return

/obj/item/weapon/peripheral/radio
	name = "Wireless card"
	icon_state = "radio_mod"
	var/frequency = 1419
	var/code = null
	var/datum/radio_frequency/radio_connection
	New()
		..()
		if(radio_controller)
			initialize()

	initialize()
		set_frequency(frequency)

	proc
		set_frequency(new_frequency)
			radio_controller.remove_object(src, frequency)
			frequency = new_frequency
			radio_connection = radio_controller.add_object(src, frequency)

	receive_command(obj/source, command, datum/signal/signal)
		if(..())
			return

		if(!signal || !radio_connection)
			return

		switch(command)
			if("send signal")
				src.radio_connection.post_signal(src, signal)

		return

	receive_signal(datum/signal/signal)
		if(!signal || (signal.encryption && signal.encryption != code))
			return

		var/datum/signal/newsignal = new
		newsignal.data = signal.data
		if(src.code)
			newsignal.encryption = src.code

		send_command("radio signal",newsignal)
		return

/obj/item/weapon/peripheral/printer
	name = "Printer module"
	desc = "A small printer designed to fit into a computer casing."
	icon_state = "printer"
	var/printing = 0

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		if(!signal)
			return

		if((command == "print") && !src.printing)
			src.printing = 1

			var/print_data = signal.data["data"]
			var/print_title = signal.data["title"]
			if(!print_data)
				src.printing = 0
				return
			spawn(50)
				var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.host.loc )
				P.info = print_data
				if(print_title)
					P.name = "paper- '[print_title]'"

				src.printing = 0
				return

		return

/obj/item/weapon/peripheral/prize_vendor
	name = "Prize vending module"
	desc = "An arcade prize dispenser designed to fit inside a computer casing."
	icon_state = "prizevendor"
	var/last_vend = 0 //Delay between vends if manually activated(ie a dude is holding it and shaking stuff out)

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		if(command == "vend prize")
			src.vend_prize()

		return

	attack_self(mob/user as mob)
		if( (last_vend + 400) < world.time)
			user << "You shake something out of [src]!"
			src.vend_prize()
			src.last_vend = world.time
		else
			user << "\red [src] isn't ready to dispense a prize yet."

		return

	proc/vend_prize()
		var/obj/item/prize
		var/prizeselect = rand(1,4)
		var/turf/prize_location = null

		if(src.host)
			prize_location = src.host.loc
		else
			prize_location = get_turf(src)

		switch(prizeselect)
			if(1)
				prize = new /obj/item/toy/gun( prize_location )
				prize.name = "cap gun"
				prize.desc = "Looks almost like the real thing!"
			if(2)
				prize = new /obj/item/device/radio/beacon( prize_location )
				prize.name = "electronic blink toy game"
				prize.desc = "Blink.  Blink.  Blink."
			if(3)
				prize = new /obj/item/toy/prize/ripley( prize_location )
				prize.name = "toy ripley"
				prize.desc = "Mini-Mecha action figure!"
			if(4)
				prize = new /obj/item/toy/sword( prize_location )
				prize.name = "toy sword"
				prize.icon = 'weapons.dmi'
				prize.icon_state = "sword1"
				prize.desc = "A sword made of cheap plastic."


/obj/item/weapon/peripheral/card_scanner
	name = "ID scanner module"
	icon_state = "card_mod"
	var/obj/item/weapon/card/id/authid = null

	attack_self(mob/user as mob)
		if(authid)
			user << "The card falls out."
			src.authid.loc = get_turf(user)
			src.authid = null
		return

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		if(!signal || (signal.data["ref_id"] != "\ref[src]") )
			return

		switch(command)
			if("eject card")
				if(src.authid)
					src.authid.loc = src.host.loc
					src.authid = null
			if("add card access")
				var/new_access = signal.data["access"]
				if(!new_access)
					return
		return

/obj/item/weapon/peripheral/beaker_holder
	name = "beaker recepticle module"
	icon_state = "beaker_holder"
	var/obj/item/weapon/reagent_containers/glass/held_beaker = null

	attack_self(mob/user as mob)
		if(held_beaker)
			user << "The module releases the beaker."
			src.held_beaker.loc = get_turf(user)
			src.held_beaker = null
		return

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		switch(command)
			if("eject beaker")
				if(src.held_beaker)
					src.held_beaker.loc = src.host.loc
					src.held_beaker = null
		return

/obj/item/weapon/peripheral/robot_module
	name = "robotics module reader"
	icon_state = "card_mod"
	var/obj/item/weapon/aiModule/module = null

	attack_self(mob/user as mob)
		if(module)
			user << "The module falls out."
			src.module.loc = get_turf(user)
			src.module = null
		return

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		switch(command)
			if("eject module")
				if(src.module)
					src.module.loc = src.host.loc
					src.module = null
			if("apply module write")
				module.install(host)
				return
		return

/obj/item/weapon/peripheral/servo
	name = "servo"
	desc = "A small motor used to move other objects."
	icon_state = "servo"

	receive_command(obj/source,command, datum/signal/signal)
		if(..())
			return

		if(!signal)
			return

		return