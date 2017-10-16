/**********************Mineral stacking unit console**************************/

/obj/machinery/mineral/stacking_unit_console
	name = "stacking machine console"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	density = 1
	anchored = 1
	var/obj/machinery/mineral/stacking_machine/machine = null
	var/machinedir = SOUTHEAST

/obj/machinery/mineral/stacking_unit_console/New()
	..()
	spawn(7)
		src.machine = locate(/obj/machinery/mineral/stacking_machine, get_step(src, machinedir))
		if (machine)
			machine.CONSOLE = src
		else
			del(src)

/obj/machinery/mineral/stacking_unit_console/process()
	updateDialog()

/obj/machinery/mineral/stacking_unit_console/attack_hand(mob/user)
	add_fingerprint(user)
	interact(user)

/obj/machinery/mineral/stacking_unit_console/interact(mob/user)
	user.set_machine(src)

	var/dat

	dat += text("<b>Stacking unit console</b><br><br>")

	if(machine.ore_iron)
		dat += text("Iron: [machine.ore_iron] <A href='?src=\ref[src];release=iron'>Release</A><br>")
	if(machine.ore_plasteel)
		dat += text("Plasteel: [machine.ore_plasteel] <A href='?src=\ref[src];release=plasteel'>Release</A><br>")
	if(machine.ore_glass)
		dat += text("Glass: [machine.ore_glass] <A href='?src=\ref[src];release=glass'>Release</A><br>")
	if(machine.ore_rglass)
		dat += text("Reinforced Glass: [machine.ore_rglass] <A href='?src=\ref[src];release=rglass'>Release</A><br>")
	if(machine.ore_plasma)
		dat += text("Plasma: [machine.ore_plasma] <A href='?src=\ref[src];release=plasma'>Release</A><br>")
	if(machine.ore_gold)
		dat += text("Gold: [machine.ore_gold] <A href='?src=\ref[src];release=gold'>Release</A><br>")
	if(machine.ore_silver)
		dat += text("Silver: [machine.ore_silver] <A href='?src=\ref[src];release=silver'>Release</A><br>")
	if(machine.ore_uranium)
		dat += text("Uranium: [machine.ore_uranium] <A href='?src=\ref[src];release=uranium'>Release</A><br>")
	if(machine.ore_diamond)
		dat += text("Diamond: [machine.ore_diamond] <A href='?src=\ref[src];release=diamond'>Release</A><br>")
	if(machine.ore_wood)
		dat += text("Wood: [machine.ore_wood] <A href='?src=\ref[src];release=wood'>Release</A><br>")
	if(machine.ore_cardboard)
		dat += text("Cardboard: [machine.ore_cardboard] <A href='?src=\ref[src];release=cardboard'>Release</A><br>")
	if(machine.ore_cloth)
		dat += text("Cloth: [machine.ore_cloth] <A href='?src=\ref[src];release=cloth'>Release</A><br>")
	if(machine.ore_leather)
		dat += text("Leather: [machine.ore_leather] <A href='?src=\ref[src];release=leather'>Release</A><br>")
	if(machine.ore_clown)
		dat += text("Bananium: [machine.ore_clown] <A href='?src=\ref[src];release=clown'>Release</A><br>")
	if(machine.ore_adamantine)
		dat += text ("Adamantine: [machine.ore_adamantine] <A href='?src=\ref[src];release=adamantine'>Release</A><br>")
	if(machine.ore_mythril)
		dat += text ("Mythril: [machine.ore_mythril] <A href='?src=\ref[src];release=mythril'>Release</A><br>")
	if(machine.ore_phazon)
		dat += text ("Phazon: [machine.ore_phazon] <A href='?src=\ref[src];release=phazon'>Release</A><br>")
	if(machine.ore_aluminum)
		dat += text ("Aluminum: [machine.ore_aluminum] <A href='?src=\ref[src];release=aluminum'>Release</A><br>")
	if(machine.ore_triberium)
		dat += text ("Triberium: [machine.ore_triberium] <A href='?src=\ref[src];release=triberium'>Release</A><br>")
	if(machine.ore_mauxite)
		dat += text ("Mauxite: [machine.ore_mauxite] <A href='?src=\ref[src];release=mauxite'>Release</A><br>")
	if(machine.ore_molitz)
		dat += text ("Molitz: [machine.ore_molitz] <A href='?src=\ref[src];release=molitz'>Release</A><br>")
	if(machine.ore_pharosium)
		dat += text ("Pharosium: [machine.ore_pharosium] <A href='?src=\ref[src];release=pharosium'>Release</A><br>")
	if(machine.ore_cobryl)
		dat += text ("Cobryl: [machine.ore_cobryl] <A href='?src=\ref[src];release=cobryl'>Release</A><br>")
	if(machine.ore_char)
		dat += text ("Char: [machine.ore_char] <A href='?src=\ref[src];release=char'>Release</A><br>")
	if(machine.ore_claretine)
		dat += text ("Claretine: [machine.ore_claretine] <A href='?src=\ref[src];release=claretine'>Release</A><br>")
	if(machine.ore_bohrum)
		dat += text ("Bohrum: [machine.ore_bohrum] <A href='?src=\ref[src];release=bohrum'>Release</A><br>")
	if(machine.ore_syreline)
		dat += text ("Syreline: [machine.ore_syreline] <A href='?src=\ref[src];release=syreline'>Release</A><br>")
	if(machine.ore_erebite)
		dat += text ("Erebite: [machine.ore_erebite] <A href='?src=\ref[src];release=erebite'>Release</A><br>")
	if(machine.ore_cerenkite)
		dat += text ("Cerenkite: [machine.ore_cerenkite] <A href='?src=\ref[src];release=cerenkite'>Release</A><br>")
	if(machine.ore_cytine)
		dat += text ("Cytine: [machine.ore_cytine] <A href='?src=\ref[src];release=cytine'>Release</A><br>")
	if(machine.ore_coal)
		dat += text ("Coal: [machine.ore_coal] <A href='?src=\ref[src];release=coal'>Release</A><br>")
	if(machine.ore_ruvium)
		dat += text ("Ruvium: [machine.ore_ruvium] <A href='?src=\ref[src];release=ruvium'>Release</A><br>")
	if(machine.ore_lovite)
		dat += text ("Lovite: [machine.ore_lovite] <A href='?src=\ref[src];release=lovite'>Release</A><br>")
	if(machine.ore_telecrystal)
		dat += text ("Telecrystal: [machine.ore_telecrystal] <A href='?src=\ref[src];release=telecrystal'>Release</A><br>")
	if(machine.ore_martian)
		dat += text ("Martian: [machine.ore_martian] <A href='?src=\ref[src];release=martian'>Release</A><br>")
	if(machine.ore_eldritch)
		dat += text ("Eldritch: [machine.ore_eldritch] <A href='?src=\ref[src];release=eldritch'>Release</A><br>")
	if(machine.ore_ice)
		dat += text ("Ice: [machine.ore_ice] <A href='?src=\ref[src];release=ice'>Release</A><br>")
	if(machine.ore_uqill)
		dat += text ("Uqill: [machine.ore_uqill] <A href='?src=\ref[src];release=uqill'>Release</A><br>")

	dat += text("<br>Stacking: [machine.stack_amt]<br><br>")

	user << browse("[dat]", "window=console_stacking_machine")
	onclose(user, "console_stacking_machine")

/obj/machinery/mineral/stacking_unit_console/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(href_list["release"])
		switch(href_list["release"])
			if ("plasma")
				if (machine.ore_plasma > 0)
					var/obj/item/stack/sheet/mineral/plasma/G = new /obj/item/stack/sheet/mineral/plasma
					G.amount = machine.ore_plasma
					G.loc = machine.output.loc
					machine.ore_plasma = 0
			if ("uranium")
				if (machine.ore_uranium > 0)
					var/obj/item/stack/sheet/mineral/uranium/G = new /obj/item/stack/sheet/mineral/uranium
					G.amount = machine.ore_uranium
					G.loc = machine.output.loc
					machine.ore_uranium = 0
			if ("glass")
				if (machine.ore_glass > 0)
					var/obj/item/stack/sheet/glass/G = new /obj/item/stack/sheet/glass
					G.amount = machine.ore_glass
					G.loc = machine.output.loc
					machine.ore_glass = 0
			if ("rglass")
				if (machine.ore_rglass > 0)
					var/obj/item/stack/sheet/rglass/G = new /obj/item/stack/sheet/rglass
					G.amount = machine.ore_rglass
					G.loc = machine.output.loc
					machine.ore_rglass = 0
			if ("gold")
				if (machine.ore_gold > 0)
					var/obj/item/stack/sheet/mineral/gold/G = new /obj/item/stack/sheet/mineral/gold
					G.amount = machine.ore_gold
					G.loc = machine.output.loc
					machine.ore_gold = 0
			if ("silver")
				if (machine.ore_silver > 0)
					var/obj/item/stack/sheet/mineral/silver/G = new /obj/item/stack/sheet/mineral/silver
					G.amount = machine.ore_silver
					G.loc = machine.output.loc
					machine.ore_silver = 0
			if ("diamond")
				if (machine.ore_diamond > 0)
					var/obj/item/stack/sheet/mineral/diamond/G = new /obj/item/stack/sheet/mineral/diamond
					G.amount = machine.ore_diamond
					G.loc = machine.output.loc
					machine.ore_diamond = 0
			if ("iron")
				if (machine.ore_iron > 0)
					var/obj/item/stack/sheet/metal/G = new /obj/item/stack/sheet/metal
					G.amount = machine.ore_iron
					G.loc = machine.output.loc
					machine.ore_iron = 0
			if ("plasteel")
				if (machine.ore_plasteel > 0)
					var/obj/item/stack/sheet/plasteel/G = new /obj/item/stack/sheet/plasteel
					G.amount = machine.ore_plasteel
					G.loc = machine.output.loc
					machine.ore_plasteel = 0
			if ("wood")
				if (machine.ore_wood > 0)
					var/obj/item/stack/sheet/wood/G = new /obj/item/stack/sheet/wood
					G.amount = machine.ore_wood
					G.loc = machine.output.loc
					machine.ore_wood = 0
			if ("cardboard")
				if (machine.ore_cardboard > 0)
					var/obj/item/stack/sheet/cardboard/G = new /obj/item/stack/sheet/cardboard
					G.amount = machine.ore_cardboard
					G.loc = machine.output.loc
					machine.ore_cardboard = 0
			if ("cloth")
				if (machine.ore_cloth > 0)
					var/obj/item/stack/sheet/cloth/G = new /obj/item/stack/sheet/cloth
					G.amount = machine.ore_cloth
					G.loc = machine.output.loc
					machine.ore_cloth = 0
			if ("leather")
				if (machine.ore_leather > 0)
					var/obj/item/stack/sheet/leather/G = new /obj/item/stack/sheet/leather
					G.amount = machine.ore_diamond
					G.loc = machine.output.loc
					machine.ore_leather = 0
			if ("clown")
				if (machine.ore_clown > 0)
					var/obj/item/stack/sheet/mineral/clown/G = new /obj/item/stack/sheet/mineral/clown
					G.amount = machine.ore_clown
					G.loc = machine.output.loc
					machine.ore_clown = 0
			if ("adamantine")
				if (machine.ore_adamantine > 0)
					var/obj/item/stack/sheet/mineral/adamantine/G = new /obj/item/stack/sheet/mineral/adamantine
					G.amount = machine.ore_adamantine
					G.loc = machine.output.loc
					machine.ore_adamantine = 0
			if ("mythril")
				if (machine.ore_mythril > 0)
					var/obj/item/stack/sheet/mineral/mythril/G = new /obj/item/stack/sheet/mineral/mythril
					G.amount = machine.ore_mythril
					G.loc = machine.output.loc
					machine.ore_mythril = 0
			if ("phazon")
				if (machine.ore_phazon > 0)
					var/obj/item/stack/sheet/mineral/phazon/G = new /obj/item/stack/sheet/mineral/phazon
					G.amount = machine.ore_phazon
					G.loc = machine.output.loc
					machine.ore_phazon = 0
			if ("aluminum")
				if (machine.ore_aluminum > 0)
					var/obj/item/stack/sheet/mineral/aluminum/G = new /obj/item/stack/sheet/mineral/aluminum
					G.amount = machine.ore_aluminum
					G.loc = machine.output.loc
					machine.ore_aluminum = 0
			if ("triberium")
				if (machine.ore_triberium > 0)
					var/obj/item/stack/sheet/mineral/triberium/G = new /obj/item/stack/sheet/mineral/triberium
					G.amount = machine.ore_triberium
					G.loc = machine.output.loc
					machine.ore_triberium = 0
			if ("mauxite")
				if (machine.ore_mauxite > 0)
					var/obj/item/stack/sheet/mineral/mauxite/G = new /obj/item/stack/sheet/mineral/mauxite
					G.amount = machine.ore_mauxite
					G.loc = machine.output.loc
					machine.ore_mauxite = 0
			if ("molitz")
				if (machine.ore_molitz > 0)
					var/obj/item/stack/sheet/mineral/molitz/G = new /obj/item/stack/sheet/mineral/molitz
					G.amount = machine.ore_molitz
					G.loc = machine.output.loc
					machine.ore_molitz = 0
			if ("pharosium")
				if (machine.ore_pharosium > 0)
					var/obj/item/stack/sheet/mineral/pharosium/G = new /obj/item/stack/sheet/mineral/pharosium
					G.amount = machine.ore_pharosium
					G.loc = machine.output.loc
					machine.ore_pharosium = 0
			if ("cobryl")
				if (machine.ore_cobryl > 0)
					var/obj/item/stack/sheet/mineral/cobryl/G = new /obj/item/stack/sheet/mineral/cobryl
					G.amount = machine.ore_cobryl
					G.loc = machine.output.loc
					machine.ore_cobryl = 0
			if ("char")
				if (machine.ore_char > 0)
					var/obj/item/stack/sheet/mineral/char/G = new /obj/item/stack/sheet/mineral/char
					G.amount = machine.ore_mythril
					G.loc = machine.output.loc
					machine.ore_char = 0
			if ("claretine")
				if (machine.ore_claretine > 0)
					var/obj/item/stack/sheet/mineral/claretine/G = new /obj/item/stack/sheet/mineral/claretine
					G.amount = machine.ore_claretine
					G.loc = machine.output.loc
					machine.ore_claretine = 0
			if ("bohrum")
				if (machine.ore_bohrum > 0)
					var/obj/item/stack/sheet/mineral/bohrum/G = new /obj/item/stack/sheet/mineral/bohrum
					G.amount = machine.ore_bohrum
					G.loc = machine.output.loc
					machine.ore_bohrum = 0
			if ("syreline")
				if (machine.ore_syreline > 0)
					var/obj/item/stack/sheet/mineral/syreline/G = new /obj/item/stack/sheet/mineral/syreline
					G.amount = machine.ore_syreline
					G.loc = machine.output.loc
					machine.ore_syreline = 0
			if ("erebite")
				if (machine.ore_erebite > 0)
					var/obj/item/stack/sheet/mineral/erebite/G = new /obj/item/stack/sheet/mineral/erebite
					G.amount = machine.ore_erebite
					G.loc = machine.output.loc
					machine.ore_erebite = 0
			if ("cerenkite")
				if (machine.ore_cerenkite > 0)
					var/obj/item/stack/sheet/mineral/cerenkite/G = new /obj/item/stack/sheet/mineral/cerenkite
					G.amount = machine.ore_cerenkite
					G.loc = machine.output.loc
					machine.ore_cerenkite = 0
			if ("cytine")
				if (machine.ore_cytine > 0)
					var/obj/item/stack/sheet/mineral/cytine/G = new /obj/item/stack/sheet/mineral/cytine
					G.amount = machine.ore_cytine
					G.loc = machine.output.loc
					machine.ore_cytine = 0
//			if ("coal")
//				if (machine.ore_coal > 0)
//					var/obj/item/stack/sheet/mineral/coal/G = new /obj/item/stack/sheet/mineral/coal
//					G.amount = machine.ore_coal
//					G.loc = machine.output.loc
//					machine.ore_coal = 0
			if ("ruvium")
				if (machine.ore_ruvium > 0)
					var/obj/item/stack/sheet/mineral/ruvium/G = new /obj/item/stack/sheet/mineral/ruvium
					G.amount = machine.ore_ruvium
					G.loc = machine.output.loc
					machine.ore_ruvium = 0
			if ("lovite")
				if (machine.ore_lovite > 0)
					var/obj/item/stack/sheet/mineral/lovite/G = new /obj/item/stack/sheet/mineral/lovite
					G.amount = machine.ore_lovite
					G.loc = machine.output.loc
					machine.ore_lovite = 0
			if ("telecrystal")
				if (machine.ore_telecrystal > 0)
					var/obj/item/stack/sheet/mineral/telecrystal/G = new /obj/item/stack/sheet/mineral/telecrystal
					G.amount = machine.ore_telecrystal
					G.loc = machine.output.loc
					machine.ore_telecrystal = 0
			if ("martian")
				if (machine.ore_martian > 0)
					var/obj/item/stack/sheet/mineral/martian/G = new /obj/item/stack/sheet/mineral/martian
					G.amount = machine.ore_martian
					G.loc = machine.output.loc
					machine.ore_martian = 0
			if ("eldritch")
				if (machine.ore_eldritch > 0)
					var/obj/item/stack/sheet/mineral/eldritch/G = new /obj/item/stack/sheet/mineral/eldritch
					G.amount = machine.ore_eldritch
					G.loc = machine.output.loc
					machine.ore_eldritch = 0
			if ("ice")
				if (machine.ore_ice > 0)
					var/obj/item/stack/sheet/mineral/ice/G = new /obj/item/stack/sheet/mineral/ice
					G.amount = machine.ore_ice
					G.loc = machine.output.loc
					machine.ore_ice = 0
			if ("uqill")
				if (machine.ore_uqill > 0)
					var/obj/item/stack/sheet/mineral/uqill/G = new /obj/item/stack/sheet/mineral/uqill
					G.amount = machine.ore_uqill
					G.loc = machine.output.loc
					machine.ore_uqill = 0
	src.updateUsrDialog()
	return


/**********************Mineral stacking unit**************************/


/obj/machinery/mineral/stacking_machine
	name = "stacking machine"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "stacker"
	density = 1
	anchored = 1.0
	var/obj/machinery/mineral/stacking_unit_console/CONSOLE
	var/stk_types = list()
	var/stk_amt   = list()
	var/obj/machinery/mineral/input = null
	var/obj/machinery/mineral/output = null
	var/ore_gold = 0;
	var/ore_silver = 0;
	var/ore_diamond = 0;
	var/ore_plasma = 0;
	var/ore_iron = 0;
	var/ore_uranium = 0;
	var/ore_clown = 0;
	var/ore_glass = 0;
	var/ore_rglass = 0;
	var/ore_plasteel = 0;
	var/ore_wood = 0
	var/ore_cardboard = 0
	var/ore_cloth = 0;
	var/ore_leather = 0;
	var/ore_adamantine = 0;
	var/ore_mythril = 0;
	var/ore_phazon = 0
	var/ore_aluminum = 0
	var/ore_triberium = 0
	var/ore_mauxite = 0
	var/ore_molitz = 0
	var/ore_pharosium = 0
	var/ore_cobryl = 0
	var/ore_char = 0
	var/ore_claretine = 0
	var/ore_bohrum = 0
	var/ore_syreline = 0
	var/ore_erebite = 0
	var/ore_cerenkite = 0
	var/ore_cytine = 0
	var/ore_coal = 0
	var/ore_ruvium = 0
	var/ore_lovite = 0
	var/ore_telecrystal = 0
	var/ore_martian = 0
	var/ore_eldritch = 0
	var/ore_ice = 0
	var/ore_uqill = 0
	var/stack_amt = 50; //ammount to stack before releassing

/obj/machinery/mineral/stacking_machine/New()
	..()
	spawn( 5 )
		for (var/dir in cardinal)
			src.input = locate(/obj/machinery/mineral/input, get_step(src, dir))
			if(src.input) break
		for (var/dir in cardinal)
			src.output = locate(/obj/machinery/mineral/output, get_step(src, dir))
			if(src.output) break
		processing_objects.Add(src)
		return
	return

/obj/machinery/mineral/stacking_machine/process()
	if (src.output && src.input)
		var/obj/item/O
		while (locate(/obj/item, input.loc))
			O = locate(/obj/item, input.loc)
			if (istype(O,/obj/item/stack/sheet/metal))
				ore_iron+= O:amount;
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/diamond))
				ore_diamond+= O:amount;
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/plasma))
				ore_plasma+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/gold))
				ore_gold+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/silver))
				ore_silver+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/clown))
				ore_clown+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/uranium))
				ore_uranium+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/glass))
				ore_glass+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/rglass))
				ore_rglass+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/plasteel))
				ore_plasteel+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/adamantine))
				ore_adamantine+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/mythril))
				ore_mythril+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/cardboard))
				ore_cardboard+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/wood))
				ore_wood+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/cloth))
				ore_cloth+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/leather))
				ore_leather+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/phazon))
				ore_phazon+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/aluminum))
				ore_aluminum+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/triberium))
				ore_triberium+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/mauxite))
				ore_mauxite+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/molitz))
				ore_molitz+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/pharosium))
				ore_pharosium+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/cobryl))
				ore_cobryl+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/char))
				ore_char+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/claretine))
				ore_claretine+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/bohrum))
				ore_bohrum+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/syreline))
				ore_syreline+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/erebite))
				ore_erebite+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/cerenkite))
				ore_cerenkite+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/cytine))
				ore_cytine+= O:amount
				del(O)
				continue
//			if (istype(O,/obj/item/stack/sheet/mineral/coal))
//				ore_coal+= O:amount
//				del(O)
//				continue
			if (istype(O,/obj/item/stack/sheet/mineral/ruvium))
				ore_ruvium+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/lovite))
				ore_lovite+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/telecrystal))
				ore_telecrystal+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/martian))
				ore_martian+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/eldritch))
				ore_eldritch+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/ice))
				ore_ice+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/stack/sheet/mineral/uqill))
				ore_uqill+= O:amount
				del(O)
				continue
			if (istype(O,/obj/item/weapon/ore/slag))
				del(O)
				continue
			O.loc = src.output.loc
	if (ore_gold >= stack_amt)
		var/obj/item/stack/sheet/mineral/gold/G = new /obj/item/stack/sheet/mineral/gold
		G.amount = stack_amt
		G.loc = output.loc
		ore_gold -= stack_amt
		return
	if (ore_silver >= stack_amt)
		var/obj/item/stack/sheet/mineral/silver/G = new /obj/item/stack/sheet/mineral/silver
		G.amount = stack_amt
		G.loc = output.loc
		ore_silver -= stack_amt
		return
	if (ore_diamond >= stack_amt)
		var/obj/item/stack/sheet/mineral/diamond/G = new /obj/item/stack/sheet/mineral/diamond
		G.amount = stack_amt
		G.loc = output.loc
		ore_diamond -= stack_amt
		return
	if (ore_plasma >= stack_amt)
		var/obj/item/stack/sheet/mineral/plasma/G = new /obj/item/stack/sheet/mineral/plasma
		G.amount = stack_amt
		G.loc = output.loc
		ore_plasma -= stack_amt
		return
	if (ore_iron >= stack_amt)
		var/obj/item/stack/sheet/metal/G = new /obj/item/stack/sheet/metal
		G.amount = stack_amt
		G.loc = output.loc
		ore_iron -= stack_amt
		return
	if (ore_clown >= stack_amt)
		var/obj/item/stack/sheet/mineral/clown/G = new /obj/item/stack/sheet/mineral/clown
		G.amount = stack_amt
		G.loc = output.loc
		ore_clown -= stack_amt
		return
	if (ore_uranium >= stack_amt)
		var/obj/item/stack/sheet/mineral/uranium/G = new /obj/item/stack/sheet/mineral/uranium
		G.amount = stack_amt
		G.loc = output.loc
		ore_uranium -= stack_amt
		return
	if (ore_glass >= stack_amt)
		var/obj/item/stack/sheet/glass/G = new /obj/item/stack/sheet/glass
		G.amount = stack_amt
		G.loc = output.loc
		ore_glass -= stack_amt
		return
	if (ore_rglass >= stack_amt)
		var/obj/item/stack/sheet/rglass/G = new /obj/item/stack/sheet/rglass
		G.amount = stack_amt
		G.loc = output.loc
		ore_rglass -= stack_amt
		return
	if (ore_plasteel >= stack_amt)
		var/obj/item/stack/sheet/plasteel/G = new /obj/item/stack/sheet/plasteel
		G.amount = stack_amt
		G.loc = output.loc
		ore_plasteel -= stack_amt
		return
	if (ore_wood >= stack_amt)
		var/obj/item/stack/sheet/wood/G = new /obj/item/stack/sheet/wood
		G.amount = stack_amt
		G.loc = output.loc
		ore_wood -= stack_amt
		return
	if (ore_cardboard >= stack_amt)
		var/obj/item/stack/sheet/cardboard/G = new /obj/item/stack/sheet/cardboard
		G.amount = stack_amt
		G.loc = output.loc
		ore_cardboard -= stack_amt
		return
	if (ore_cloth >= stack_amt)
		var/obj/item/stack/sheet/cloth/G = new /obj/item/stack/sheet/cloth
		G.amount = stack_amt
		G.loc = output.loc
		ore_cloth -= stack_amt
		return
	if (ore_leather >= stack_amt)
		var/obj/item/stack/sheet/leather/G = new /obj/item/stack/sheet/leather
		G.amount = stack_amt
		G.loc = output.loc
		ore_leather -= stack_amt
		return
	if (ore_adamantine >= stack_amt)
		var/obj/item/stack/sheet/mineral/adamantine/G = new /obj/item/stack/sheet/mineral/adamantine
		G.amount = stack_amt
		G.loc = output.loc
		ore_adamantine -= stack_amt
		return
	if (ore_mythril >= stack_amt)
		var/obj/item/stack/sheet/mineral/mythril/G = new /obj/item/stack/sheet/mineral/mythril
		G.amount = stack_amt
		G.loc = output.loc
		ore_mythril -= stack_amt
		return
	if (ore_phazon >= stack_amt)
		var/obj/item/stack/sheet/mineral/phazon/G = new /obj/item/stack/sheet/mineral/phazon
		G.amount = stack_amt
		G.loc = output.loc
		ore_phazon -= stack_amt
		return
	if (ore_aluminum >= stack_amt)
		var/obj/item/stack/sheet/mineral/aluminum/G = new /obj/item/stack/sheet/mineral/aluminum
		G.amount = stack_amt
		G.loc = output.loc
		ore_aluminum -= stack_amt
		return
	if (ore_triberium >= stack_amt)
		var/obj/item/stack/sheet/mineral/triberium/G = new /obj/item/stack/sheet/mineral/triberium
		G.amount = stack_amt
		G.loc = output.loc
		ore_triberium -= stack_amt
		return
	if (ore_mauxite >= stack_amt)
		var/obj/item/stack/sheet/mineral/mauxite/G = new /obj/item/stack/sheet/mineral/mauxite
		G.amount = stack_amt
		G.loc = output.loc
		ore_mauxite -= stack_amt
		return
	if (ore_molitz >= stack_amt)
		var/obj/item/stack/sheet/mineral/molitz/G = new /obj/item/stack/sheet/mineral/molitz
		G.amount = stack_amt
		G.loc = output.loc
		ore_molitz -= stack_amt
		return
	if (ore_pharosium >= stack_amt)
		var/obj/item/stack/sheet/mineral/pharosium/G = new /obj/item/stack/sheet/mineral/pharosium
		G.amount = stack_amt
		G.loc = output.loc
		ore_pharosium -= stack_amt
		return
	if (ore_cobryl >= stack_amt)
		var/obj/item/stack/sheet/mineral/cobryl/G = new /obj/item/stack/sheet/mineral/cobryl
		G.amount = stack_amt
		G.loc = output.loc
		ore_cobryl -= stack_amt
		return
	if (ore_char >= stack_amt)
		var/obj/item/stack/sheet/mineral/char/G = new /obj/item/stack/sheet/mineral/char
		G.amount = stack_amt
		G.loc = output.loc
		ore_char -= stack_amt
		return
	if (ore_claretine >= stack_amt)
		var/obj/item/stack/sheet/mineral/claretine/G = new /obj/item/stack/sheet/mineral/claretine
		G.amount = stack_amt
		G.loc = output.loc
		ore_claretine -= stack_amt
		return
	if (ore_cytine >= stack_amt)
		var/obj/item/stack/sheet/mineral/cytine/G = new /obj/item/stack/sheet/mineral/cytine
		G.amount = stack_amt
		G.loc = output.loc
		ore_cytine -= stack_amt
		return
	if (ore_bohrum >= stack_amt)
		var/obj/item/stack/sheet/mineral/bohrum/G = new /obj/item/stack/sheet/mineral/bohrum
		G.amount = stack_amt
		G.loc = output.loc
		ore_bohrum -= stack_amt
		return
	if (ore_syreline >= stack_amt)
		var/obj/item/stack/sheet/mineral/syreline/G = new /obj/item/stack/sheet/mineral/syreline
		G.amount = stack_amt
		G.loc = output.loc
		ore_syreline -= stack_amt
		return
	if (ore_erebite >= stack_amt)
		var/obj/item/stack/sheet/mineral/erebite/G = new /obj/item/stack/sheet/mineral/erebite
		G.amount = stack_amt
		G.loc = output.loc
		ore_erebite -= stack_amt
		return
	if (ore_cerenkite >= stack_amt)
		var/obj/item/stack/sheet/mineral/cerenkite/G = new /obj/item/stack/sheet/mineral/cerenkite
		G.amount = stack_amt
		G.loc = output.loc
		ore_cerenkite -= stack_amt
		return
//	if (ore_coal >= stack_amt)
//		var/obj/item/stack/sheet/mineral/coal/G = new /obj/item/stack/sheet/mineral/coal
//		G.amount = stack_amt
//		G.loc = output.loc
//		ore_coal -= stack_amt
//		return
	if (ore_ruvium >= stack_amt)
		var/obj/item/stack/sheet/mineral/ruvium/G = new /obj/item/stack/sheet/mineral/ruvium
		G.amount = stack_amt
		G.loc = output.loc
		ore_ruvium -= stack_amt
		return
	if (ore_lovite >= stack_amt)
		var/obj/item/stack/sheet/mineral/lovite/G = new /obj/item/stack/sheet/mineral/lovite
		G.amount = stack_amt
		G.loc = output.loc
		ore_lovite -= stack_amt
		return
	if (ore_telecrystal >= stack_amt)
		var/obj/item/stack/sheet/mineral/telecrystal/G = new /obj/item/stack/sheet/mineral/telecrystal
		G.amount = stack_amt
		G.loc = output.loc
		ore_telecrystal -= stack_amt
		return
	if (ore_martian >= stack_amt)
		var/obj/item/stack/sheet/mineral/martian/G = new /obj/item/stack/sheet/mineral/martian
		G.amount = stack_amt
		G.loc = output.loc
		ore_martian -= stack_amt
		return
	if (ore_eldritch >= stack_amt)
		var/obj/item/stack/sheet/mineral/eldritch/G = new /obj/item/stack/sheet/mineral/eldritch
		G.amount = stack_amt
		G.loc = output.loc
		ore_eldritch -= stack_amt
		return
	if (ore_ice >= stack_amt)
		var/obj/item/stack/sheet/mineral/ice/G = new /obj/item/stack/sheet/mineral/ice
		G.amount = stack_amt
		G.loc = output.loc
		ore_ice -= stack_amt
		return
	if (ore_uqill >= stack_amt)
		var/obj/item/stack/sheet/mineral/uqill/G = new /obj/item/stack/sheet/mineral/uqill
		G.amount = stack_amt
		G.loc = output.loc
		ore_uqill -= stack_amt
		return
	return