/datum/disease/pierrot_throat
	name = "Pierrot's Throat"
	max_stages = 4
	spread = "Airborne"
	cure = "A whole banana."
	cure_id = "banana"
	cure_chance = 75
	agent = "H0NI<42 Virus"
	affected_species = list("Human")
	permeability_mod = 0.75
	desc = "If left untreated the subject will probably drive others to insanity."
	severity = "Medium"
	longevity = 400

/datum/disease/pierrot_throat/stage_act()
	..()
	switch(stage)
		if(1)
			if(prob(10)) affected_mob << "\red �� ���������� ���&#255; ������ �����."
		if(2)
			if(prob(10)) affected_mob << "\red �� ��������� ������ ������."
		if(3)
			if(prob(10)) affected_mob << "\red �� ��������� ������ � �������: <b>�����!</b>"
		if(4)
			if(prob(5)) affected_mob.say( pick( list("��-��-��!", "��-��!", "��-��-��.", "��-��-��?", "��-��-��!!", "�����?!", "���-�����...") ) )