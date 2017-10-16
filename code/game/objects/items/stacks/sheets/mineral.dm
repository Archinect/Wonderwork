/*
Mineral Sheets
	Contains:
		- Sandstone
		- Diamond
		- Uranium
		- Plasma
		- Gold
		- Silver
		- Clown
	Others:
		- Adamantine
		- Mythril
		- Enriched Uranium
*/

/*
 * Sandstone
 */
/obj/item/stack/sheet/mineral/sandstone
	name = "sandstone bricks"
	desc = "This appears to be a combination of both sand and stone."
	singular_name = "sandstone brick"
	icon_state = "sheet-sandstone"
	throw_speed = 4
	throw_range = 5
	origin_tech = "materials=1"
	sheettype = "sandstone"

var/global/list/datum/stack_recipe/sandstone_recipes = list ( \
	new/datum/stack_recipe("pile of dirt", /obj/machinery/hydroponics/soil, 3, time = 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("sandstone door", /obj/structure/mineral_door/sandstone, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("sandstone statue", /obj/structure/statue/sandstone/assistant, 10, one_per_turf = 1, on_floor = 1), \
/*	new/datum/stack_recipe("sandstone wall", ???), \
		new/datum/stack_recipe("sandstone floor", ???),\ */
	)

/obj/item/stack/sheet/mineral/sandstone/New(var/loc, var/amount=null)
	recipes = sandstone_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Diamond
 */
/obj/item/stack/sheet/mineral/diamond
	name = "diamond"
	icon_state = "sheet-diamond"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_range = 3
	origin_tech = "materials=6"
	perunit = 3750
	sheettype = "diamond"

var/global/list/datum/stack_recipe/diamond_recipes = list ( \
	new/datum/stack_recipe("diamond door", /obj/structure/mineral_door/transparent/diamond, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("diamond floor tile", /obj/item/stack/tile/diamond, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/diamond/New(var/loc, var/amount=null)
	recipes = diamond_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Uranium
 */
/obj/item/stack/sheet/mineral/uranium
	name = "uranium"
	icon_state = "sheet-uranium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 2000
	sheettype = "uranium"

var/global/list/datum/stack_recipe/uranium_recipes = list ( \
	new/datum/stack_recipe("uranium door", /obj/structure/mineral_door/uranium, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("uranium statue", /obj/structure/statue/uranium/eng, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("uranium floor tile", /obj/item/stack/tile/uranium, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/uranium/New(var/loc, var/amount=null)
	recipes = uranium_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Plasma
 */
/obj/item/stack/sheet/mineral/plasma
	name = "solid plasma"
	icon_state = "sheet-plasma"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "plasmatech=2;materials=2"
	perunit = 2000
	sheettype = "plasma"

var/global/list/datum/stack_recipe/plasma_recipes = list ( \
	new/datum/stack_recipe("plasma door", /obj/structure/mineral_door/transparent/plasma, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("plasma statue", /obj/structure/statue/plasma/scientist, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("plasma floor tile", /obj/item/stack/tile/plasma, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/plasma/New(var/loc, var/amount=null)
	recipes = plasma_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/obj/item/stack/sheet/plastic
	name = "Plastic"
	icon_state = "sheet-plastic"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=3"
	perunit = 2000

var/global/list/datum/stack_recipe/plastic_recipes = list ( \
	new/datum/stack_recipe("plastic crate", /obj/structure/closet/crate/pcrate, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("plastic ashtray", /obj/item/ashtray/plastic, 2, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("plastic fork", /obj/item/weapon/kitchen/utensil/pfork, 1, on_floor = 1), \
	new/datum/stack_recipe("plastic spoon", /obj/item/weapon/kitchen/utensil/pspoon, 1, on_floor = 1), \
	new/datum/stack_recipe("plastic knife", /obj/item/weapon/kitchen/utensil/pknife, 1, on_floor = 1), \
	new/datum/stack_recipe("plastic bag", /obj/item/weapon/storage/bag/plasticbag, 3, on_floor = 1), \
	)

/obj/item/stack/sheet/plastic/New(var/loc, var/amount=null)
	recipes = plastic_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Gold
 */
/obj/item/stack/sheet/mineral/gold
	name = "gold"
	icon_state = "sheet-gold"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000
	sheettype = "gold"

var/global/list/datum/stack_recipe/gold_recipes = list ( \
	new/datum/stack_recipe("golden door", /obj/structure/mineral_door/gold, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("gold floor tile", /obj/item/stack/tile/gold, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/gold/New(var/loc, var/amount=null)
	recipes = gold_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Silver
 */
/obj/item/stack/sheet/mineral/silver
	name = "silver"
	icon_state = "sheet-silver"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=3"
	perunit = 2000
	sheettype = "silver"

var/global/list/datum/stack_recipe/silver_recipes = list ( \
	new/datum/stack_recipe("silver door", /obj/structure/mineral_door/silver, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("silver floor tile", /obj/item/stack/tile/silver, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/silver/New(var/loc, var/amount=null)
	recipes = silver_recipes
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()

/*
 * Clown
 */
/obj/item/stack/sheet/mineral/clown
	name = "bananium"
	icon_state = "sheet-clown"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000
	sheettype = "clown"

var/global/list/datum/stack_recipe/clown_recipes = list ( \
	new/datum/stack_recipe("bananium statue", /obj/structure/statue/bananium/clown, 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("bananium floor tile", /obj/item/stack/tile/bananium, 1, 4, 20), \
	)

/obj/item/stack/sheet/mineral/clown/New(var/loc, var/amount=null)
	pixel_x = rand(0,4)-4
	pixel_y = rand(0,4)-4
	..()


/****************************** Others ****************************/

/*
 * Enriched Uranium
 */
/obj/item/stack/sheet/mineral/enruranium
	name = "enriched uranium"
	icon_state = "sheet-enruranium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 1000

/*
 * Adamantine
 */
/obj/item/stack/sheet/mineral/adamantine
	name = "adamantine"
	icon_state = "sheet-adamantine"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000

/*
 * Mythril
 */
/obj/item/stack/sheet/mineral/mythril
	name = "mythril"
	icon_state = "sheet-mythril"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 2000


/obj/item/stack/sheet/mineral/aluminum
	name = "aluminum"
	icon_state = "sheet-aluminum"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=1"
	perunit = 2000


/obj/item/stack/sheet/mineral/triberium
	name = "triberium"
	icon_state = "sheet-triberium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=8"
	perunit = 2000


/obj/item/stack/sheet/mineral/pharosium
	name = "pharosium"
	icon_state = "sheet-pharosium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/char
	name = "char"
	icon_state = "sheet-char"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/claretine
	name = "claretine"
	icon_state = "sheet-claretine"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/cobryl
	name = "cobryl"
	icon_state = "sheet-cobryl"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=6"
	perunit = 3750


/obj/item/stack/sheet/mineral/bohrum
	name = "bohrum"
	icon_state = "sheet-bohrum"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=4"
	perunit = 3750


/obj/item/stack/sheet/mineral/syreline
	name = "syreline"
	icon_state = "sheet-syreline"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/erebite
	name = "erebite"
	icon_state = "sheet-erebite"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=6"
	perunit = 3750


/obj/item/stack/sheet/mineral/cerenkite
	name = "cerenkite"
	icon_state = "sheet-cerenkite"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/cytine
	name = "cytine"
	icon_state = "sheet-cytine"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/uqill
	name = "uqill"
	icon_state = "sheet-uqill"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/telecrystal
	name = "telecrystal"
	icon_state = "sheet-telecrystal"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/mauxite
	name = "mauxite"
	icon_state = "sheet-mauxite"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750


/obj/item/stack/sheet/mineral/molitz
	name = "molitz"
	icon_state = "sheet-molitz"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/phazon
	name = "phazon"
	desc = "Holy christ what is this?"
	icon_state = "sheet-phazon"
	sheettype = "phazon"
	perunit = 1500
	throwforce = 15.0
	flags = FPRINT
	origin_tech = "materials=9"

/obj/item/stack/sheet/mineral/ice
	name = "ice"
	icon_state = "sheet-ice"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=3"
	perunit = 3750

/obj/item/stack/sheet/mineral/molitz
	name = "molitz"
	icon_state = "sheet-molitz"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/eldritch
	name = "eldritch"
	icon_state = "sheet-eldritch"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/martian
	name = "martian"
	icon_state = "sheet-martian"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/lovite
	name = "lovite"
	icon_state = "sheet-lovite"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/ruvium
	name = "ruvium"
	icon_state = "sheet-ruvium"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/spacelag
	name = "$f&sf&sgs&lag"
	icon_state = "sheet-spacelag"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=5"
	perunit = 3750

/obj/item/stack/sheet/mineral/soulsteel
	name = "soulsteel"
	icon_state = "sheet-soulsteel"
	force = 5.0
	throwforce = 5
	w_class = 3.0
	throw_speed = 3
	throw_range = 3
	origin_tech = "materials=9"
	perunit = 3750