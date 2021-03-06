/*
	In this file we modify the job datums when the ministation.dm file is included/ticked.
	Since we will be overriden by the job datums, we have to modify the variables in the constructor.
*/


/datum/job/New()
	..()
	supervisors = "the captain and the head of personnel"

/datum/job/assistant // Here so assistant appears on the top of the select job list.

// Command

/datum/job/captain/New()
	..()
	supervisors = "Nanotrasen and Central Command"

/datum/job/hop/New()
	..()
	supervisors = "the captain and Central Command"

/datum/job/hop/get_access()
	return get_all_accesses()



// Hydro

/datum/job/hydro/New()
	..()
	total_positions = 2
	spawn_positions = 2

// Engineering

/datum/job/atmos/New()
	..()
	total_positions = 1
	spawn_positions = 1

/datum/job/engineer/New()
	..()
	total_positions = 2
	spawn_positions = 2
	access = list(access_eva, access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_atmospherics, access_tcomsat)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels, access_external_airlocks, access_construction, access_tcomsat, access_atmospherics)

// Medical

/datum/job/doctor/New()
	..()
	total_positions = 2
	spawn_positions = 2
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_morgue, access_surgery)


/datum/job/chemist/New()
	..()
	total_positions = 1
	spawn_positions = 1
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics)
	minimal_access = list(access_medical, access_chemistry)

/datum/job/geneticist/New()
	..()
	total_positions = 1
	spawn_positions = 1

// Science

/datum/job/roboticist/New()
	..()
	total_positions = 1
	spawn_positions = 1

/datum/job/scientist/New()
	..()
	total_positions = 2
	spawn_positions = 2
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenobiology, access_robotics)

// Security

/datum/job/officer/New()
	..()
	total_positions = 5
	spawn_positions = 5
	access = list(access_security, access_sec_doors, access_brig, access_court)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_court)

/datum/job/cyborg/New()
	..()
	total_positions = 1
	spawn_positions = 1







