
/obj/machinery/computer2
	name = "computer"
	desc = "A computer workstation."
	icon = 'computer2.dmi'
	icon_state = "computer"
	density = 1
	anchored = 1.0
	req_access = list() //This doesn't determine PROGRAM req access, just the access needed to install/delete programs.
	var/datum/radio_frequency/radio_connection					//Used whenever a program communicates via radio, like the messenger
	var/obj/item/weapon/motherboard/mainboard = null			//Will remove variable in the future
	var/obj/item/weapon/disk/data/fixed_disk/hd = null			//Can only have one hard drive, will change in the future
	var/datum/computer/file/computer_program/active_program		//Text from this program is displayed when you slap the computer
	var/datum/computer/file/computer_program/host_program		//active_program is set to this when the normal active quits, if available
	//var/screen_size = /obj/computer2frame						//Different frame for arcade cabinets, etc.
	var/list/processing_programs = list()						//These programs are processed every /obj/machinery/computer2/process()
	var/obj/item/weapon/card/id/authid = null					//For records computers etc.
	var/obj/item/weapon/card/id/auxid = null					//For computers that need two ids for some reason, like the card access computer.
	var/obj/item/weapon/disk/data/diskette = null				//Inserted data disk
	var/list/peripherals = list()
	var/obj/overlay/compscreen = null							//The overlay that will represent the computer's screen
	var/startup_progress = 0									//How far along the computer is in its startup progress
	var/allow_datadisk = 1										//Can you insert a data disk into it?
	var/screen_size = "heavy"									//Used in screen resolution checks, set by computer2frame
	var/frame_type = /obj/structure/computer2frame				//Used in disassembly
	var/autoboot = 0											//Whether the system boots when spawned

	var/obj/machinery/camera/current = null						//Used by the security cam program
	var/authenticated = 0.0										//For ID changer, etc
	var/moneyinserted = 0
	var/pincode

	//Setup for Starting program & peripherals
	var/setup_starting_program = null //If set to a program path it will start with this one active.
	var/setup_starting_peripheral = null //Spawn with radio card and whatever path is here.
	var/setup_drive_size = 64.0 //How big is the drive (set to 0 for no drive)
	var/setup_id_tag
	var/setup_has_radio = 0 //Does it spawn with a radio peripheral?
	var/setup_radio_tag
	var/setup_frequency = 1411

/obj/item/weapon/disk/data
	var/datum/computer/folder/root = null
	var/file_amount = 32.0
	var/file_used = 0.0
	var/portable = 1
	var/title = "Data Disk"
	New()
		src.root = new /datum/computer/folder
		src.root.holder = src
		src.root.name = "root"

/obj/item/weapon/disk/data/fixed_disk
	name = "Storage Drive"
	icon_state = "harddisk"
	title = "Storage Drive"
	file_amount = 80.0
	portable = 0

	attack_self(mob/user as mob)
		return

/obj/item/weapon/disk/data/computer2test
	name = "Programme Diskette"
	file_amount = 128.0
	New()
		..()
		src.root.add_file( new /datum/computer/file/computer_program/arcade(src))
		src.root.add_file( new /datum/computer/file/computer_program/med_data(src))
		src.root.add_file( new /datum/computer/file/computer_program/airlock_control(src))
		src.root.add_file( new /datum/computer/file/computer_program/messenger(src))
		src.root.add_file( new /datum/computer/file/computer_program/progman(src))

/obj/machinery/computer2/medical
	name = "Medical computer"
	icon_state = "dna"
	setup_has_radio = 1
	setup_starting_program = /datum/computer/file/computer_program/med_data
	setup_starting_peripheral = /obj/item/weapon/peripheral/printer

/obj/machinery/computer2/arcade
	name = "arcade machine"
	icon_state = "arcade"
	desc = "An arcade machine."
	setup_drive_size = 16.0
	setup_starting_program = /datum/computer/file/computer_program/arcade
	setup_starting_peripheral = /obj/item/weapon/peripheral/prize_vendor


/obj/machinery/computer2/New()
	..()

	spawn(2)

		if(setup_mainboard && !mainboard)
			mainboard = new /obj/item/weapon/motherboard (src)

		if(setup_has_radio)
			var/obj/item/weapon/peripheral/radio/radio = new /obj/item/weapon/peripheral/radio(src)
			radio.frequency = setup_frequency
			radio.code = setup_radio_tag

		if(!hd && (setup_drive_size > 0))
			hd = new /obj/item/weapon/disk/data/fixed_disk(src)
			hd.file_amount = setup_drive_size

		if(ispath(setup_starting_peripheral))
			new setup_starting_peripheral(src)

		if(ispath(setup_starting_program))
			active_program = new setup_starting_program
			active_program.id_tag = setup_id_tag

			hd.file_amount = max(hd.file_amount, active_program.size)

			active_program.transfer_holder(hd)

		power_change()
		if(autoboot)
			computer_startup()

/obj/machinery/computer2/attack_hand(mob/user as mob)
	if(..())
		return

	user.machine = src

	var/dat
	if((src.active_program) && (src.active_program.master == src) && (src.active_program.holder in src))
		dat = src.active_program.return_text()
	else
		dat = "<TT><b>Thinktronic BIOS V1.4</b><br><br>"

		dat += "Current ID: <a href='?src=\ref[src];id=auth'>[src.authid ? "[src.authid.name]" : "----------"]</a><br>"
		dat += "Auxiliary ID: <a href='?src=\ref[src];id=aux'>[src.auxid ? "[src.auxid.name]" : "----------"]</a><br><br>"

		var/progdat
		if((src.hd) && (src.hd.root))
			for(var/datum/computer/file/computer_program/P in src.hd.root.contents)
				progdat += "<tr><td>[P.name]</td><td>Size: [P.size]</td>"

				progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=run'>Run</a></td>"

				if(P in src.processing_programs)
					progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=unload'>Halt</a></td>"
				else
					progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=load'>Load</a></td>"

				progdat += "<td><a href='byond://?src=\ref[src];file=\ref[P];function=delete'>Del</a></td></tr>"

				continue

			dat += "Disk Space: \[[src.hd.file_used]/[src.hd.file_amount]\]<br>"
			dat += "<b>Programs on Fixed Disk:</b><br>"

			if(!progdat)
				progdat = "No programs found.<br>"
			dat += "<center><table cellspacing=4>[progdat]</table></center>"

		else

			dat += "<b>Programs on Fixed Disk:</b><br>"
			dat += "<center>No fixed disk detected.</center><br>"

		dat += "<br>"

		progdat = null
		if((src.diskette) && (src.diskette.root))

			dat += "<font size=1><a href='byond://?src=\ref[src];disk=1'>Eject</a></font><br>"

			for(var/datum/computer/file/computer_program/P in src.diskette.root.contents)
				progdat += "<tr><td>[P.name]</td><td>Size: [P.size]</td>"
				progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=run'>Run</a></td>"

				if(P in src.processing_programs)
					progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=unload'>Halt</a></td>"
				else
					progdat += "<td><a href='byond://?src=\ref[src];prog=\ref[P];function=load'>Load</a></td>"

				progdat += "<td><a href='byond://?src=\ref[src];file=\ref[P];function=install'>Install</a></td></tr>"

				continue

			dat += "Disk Space: \[[src.diskette.file_used]/[src.diskette.file_amount]\]<br>"
			dat += "<b>Programs on Disk:</b><br>"

			if(!progdat)
				progdat = "No data found.<br>"
			dat += "<center><table cellspacing=4>[progdat]</table></center>"

		else

			dat += "<b>Programs on Disk:</b><br>"
			dat += "<center>No diskette loaded.</center><br>"

		dat += "</TT>"

	user << browse(dat,"window=comp2")
	onclose(user,"comp2")
	return

/obj/machinery/computer2/Topic(href, href_list)
	if(..())
		return

	if(!src.active_program)
		if((href_list["prog"]) && (href_list["function"]))
			var/datum/computer/file/computer_program/newprog = locate(href_list["prog"])
			if(newprog && istype(newprog))
				switch(href_list["function"])
					if("run")
						src.run_program(newprog)
					if("load")
						src.load_program(newprog)
					if("unload")
						src.unload_program(newprog)
		if((href_list["file"]) && (href_list["function"]))
			var/datum/computer/file/newfile = locate(href_list["file"])
			if(!newfile)
				return
			switch(href_list["function"])
				if("install")
					if((src.hd) && (src.hd.root) && (src.allowed(usr)))
						newfile.copy_file_to_folder(src.hd.root)

				if("delete")
					if(src.allowed(usr))
						src.delete_file(newfile)

	//If there is already one loaded eject, or if not and they have one insert it.
	if (href_list["id"])
		switch(href_list["id"])
			if("auth")
				if(!isnull(src.authid))
					src.authid.loc = get_turf(src)
					src.authid = null
				else
					var/obj/item/I = usr.equipped()
					if (istype(I, /obj/item/weapon/card/id))
						usr.drop_item()
						I.loc = src
						src.authid = I
			if("aux")
				if(!isnull(src.auxid))
					src.auxid.loc = get_turf(src)
					src.auxid = null
				else
					var/obj/item/I = usr.equipped()
					if (istype(I, /obj/item/weapon/card/id))
						usr.drop_item()
						I.loc = src
						src.auxid = I

	//Same but for a data disk
	else if (href_list["disk"])
		if(!isnull(src.diskette))
			src.diskette.loc = get_turf(src)
			src.diskette = null
/*		else
			var/obj/item/I = usr.equipped()
			if (istype(I, /obj/item/weapon/disk/data))
				usr.drop_item()
				I.loc = src
				src.diskette = I
*/
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return

/obj/machinery/computer2/process()
	if(stat & (NOPOWER|BROKEN))
		return
	use_power(250)

	for(var/datum/computer/file/computer_program/P in src.processing_programs)
		P.process()

	return

/obj/machinery/computer2/power_change()
	if(stat & BROKEN)
		add_screen_overlay("[screen_size]-b")

	else if(powered())
		icon_state = src.base_icon_state
		stat &= ~NOPOWER
	else
		spawn(rand(0, 15))
			if(startup_progress)
				computer_shutdown()
			stat |= NOPOWER


/obj/machinery/computer2/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/disk/data)) //INSERT SOME DISKETTES
		if ((!diskette) && W:portable)
			user.machine = src
			user.drop_item()
			W.loc = src
			diskette = W
			user << "You insert [W]."
			updateUsrDialog()
			return

	else if (istype(W, /obj/item/weapon/screwdriver))
		if(startup_progress > 0)
			if(mainboard)
				mainboard.burnt = 1							//GOOD JOB IDIOT
				mainboard.icon_state = "mainboard_burnt"	//HAVE FUN WITH YOUR BRICK
			if(shocked(user))
				computer_shutdown()
				return
			else
				computer_shutdown()
		playsound(loc, 'Screwdriver.ogg', 50, 1)
		if(do_after(user, 20))
			var/obj/structure/computer2frame/A = new frame_type( loc )

			A.pixel_x = pixel_x
			A.pixel_y = pixel_y
			A.density = density

			if (stat & BROKEN)
				user << "\blue The broken glass falls out."
				new /obj/item/weapon/shard( loc )
				A.state = 3
				A.icon_state = "[A.screen_size]3"
			else
				user << "\blue You disconnect the monitor."
				A.state = 4
				A.icon_state = "[A.screen_size]4"

			for (var/obj/item/weapon/peripheral/C in peripherals)
				C.loc = A
				A.peripherals.Add(C)

			if(diskette)
				diskette.loc = loc

			//TO-DO: move card reading to peripheral cards instead
			if(authid)
				authid.loc = loc

			if(auxid)
				auxid.loc = loc

			if(hd)
				hd.loc = A
				A.hd = hd

			if(mainboard)
				//A.mainboard = new /obj/item/weapon/periph_mobo(A)
				//A.mainboard.created_name = name
				mainboard.loc = A
				A.mainboard = mainboard
				A.mainboard_secure = 1

			A.anchored = 1
			del(src)

	else
		attack_hand(user)
	return

/obj/machinery/computer2/proc/computer_startup()
	if(stat & (BROKEN|NOPOWER))
		return
	if(mainboard)
		if(!mainboard.burnt)
			startup_progress = 1
			change_screen_to("startup_[screen_size]")
			//flick("startup", compscreen) Doesn't work with overlays :(
			spawn(1)

				sleep(35)

				change_screen_to("loadprog_[screen_size]")
				startup_progress = 2

				sleep(5)

				if(active_program)
					change_screen_to_prog(active_program)
				else
					change_screen_to("bioswait_[screen_size]")

				startup_progress = 3
		else
			visible_message("\blue The [name] beeps twice!","\blue You hear two beeps!") //Make up cryptic error feedback all day every day
	else
		visible_message("\blue The [name] beeps!","\blue You hear a beep!")
	return

/obj/machinery/computer2/proc/computer_shutdown()
	change_screen_to("bioswait_[screen_size]")
	for(var/datum/computer/file/computer_program/program in processing_programs)
		unload_program(program)
	sleep(15)
	remove_screen_overlay()
	startup_progress = 0
	stat |= NOPOWER
	spawn(5)
		stat &= ~NOPOWER

/obj/machinery/computer2/proc/send_command(command, datum/signal/signal)
	for(var/obj/item/weapon/peripheral/P in src.peripherals)
		P.receive_command(src, command, signal)

	del(signal)

/obj/machinery/computer2/proc/receive_command(obj/source, command, datum/signal/signal)
	if(source in src.contents)

		for(var/datum/computer/file/computer_program/P in src.processing_programs)
			P.receive_command(src, command, signal)

		del(signal)

	return


/obj/machinery/computer2/proc/run_program(datum/computer/file/computer_program/program,datum/computer/file/computer_program/host)
	if(!program)
		return 0

//	src.unload_program(src.active_program)

	if(src.load_program(program))
		if(host && istype(host))
			src.host_program = host
		else
			src.host_program = null

		src.active_program = program
		return 1

	return 0

/obj/machinery/computer2/proc/load_program(datum/computer/file/computer_program/program)
	if((!program) || (!program.holder))
		return 0

	if(!(program.holder in src))
//		world << "Not in src"
		program = new program.type
		program.transfer_holder(src.hd)

	if(program.master != src)
		program.master = src

	if(program in src.processing_programs)
		return 1
	else
		src.processing_programs.Add(program)
		return 1

	return 0

/obj/machinery/computer2/proc/unload_program(datum/computer/file/computer_program/program)
	if((!program) || (!src.hd))
		return 0

	if(program in src.processing_programs)
		src.processing_programs.Remove(program)
		return 1

	return 0

/obj/machinery/computer2/proc/change_screen_to(var/screen_icon_state)
	remove_screen_overlay()
	compscreen = new /obj/overlay(  )
	compscreen.icon = 'computer2.dmi'
	compscreen.icon_state = screen_icon_state
	overlays = list(compscreen)

/obj/machinery/computer2/proc/change_screen_to_prog(var/datum/computer/file/computer_program/prog)
	if(prog)
		remove_screen_overlay()
		compscreen = new /obj/overlay(  )
		var/icon/compscreenicon = icon('computer2.dmi', prog.program_screen_icon)
		//compscreen.icon = 'computer2.dmi'
		//compscreen.icon_state = prog.program_screen_icon
		if(prog.resolution != screen_size)
			switch(screen_size)
				//if("heavy")		//Heavy screen's the largest out of any frame and smaller screens fit so whatever
				if("atmframe")
					compscreenicon.Crop(11,17,22,25)
					compscreen.pixel_x = 10
					compscreen.pixel_y = 16			//Hardcoded until I find a better way
				if("arcade")
					compscreenicon.Crop(10,16,21,26)
					compscreen.pixel_x = 9
					compscreen.pixel_y = 15
		compscreen.icon = compscreenicon
		overlays = list(compscreen)

/obj/machinery/computer2/proc/add_screen_overlay(var/over_icon_state)
	var/obj/overlay/scrover = new /obj/overlay(  )
	scrover.icon = 'computer2.dmi'
	scrover.icon_state = over_icon_state
	overlays.Add(scrover)

/obj/machinery/computer2/proc/remove_screen_overlay()
	if(compscreen)
		compscreen.pixel_x = 0
		compscreen.pixel_y = 0
		overlays.Remove(compscreen)

/obj/machinery/computer2/proc/delete_file(datum/computer/file/file)
	//world << "Deleting [file]..."
	if((!file) || (!file.holder) || (file.holder.read_only))
		//world << "Cannot delete :("
		return 0

	if(file in src.processing_programs)
		src.processing_programs.Remove(file)

	if(src.active_program == file)
		src.active_program = null

//	file.holder.root.remove_file(file)

	//world << "Now calling del on [file]..."
	del(file)
	return 1