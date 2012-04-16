' "The Mansion II"
' Created with QDK 3.53 - UNREGISTERED VERSION

define game <The Mansion II>
	asl-version <350>
	gametype singleplayer
	start <Darkness>
	game author <Nick Dablin>
	game version <1.0>
	game copyright <©Nick Dablin 2005>
	game info <Created with QDK 3.53 - UNREGISTERED EVALUATION VERSION.>
	startscript {
		msg <The Mansion II|n------------------|n|nAfter your uncle's untimely death, you explored his empty mansion to find the truth about his demise. You learned that your uncle's scientific skills were being abused by a sinister corporation developing an untraceable toxin for assassinations, and that when your uncle tried to destroy his work, he was silenced.|nYou were confronted by the corporation's agents, but fought back, killing one. Unfortunately you were struck by a tazer before you could escape from the mansion. Unconsciousness took you and you remember nothing until now. You have awoken in darkness, a bag on your head and handcuffs on your wrists...|n|n|crFor frequently asked questions, type FAQ and hit enter.>
		give <Handcuffs>
		wait <Press any key when ready...>
	}
	command <faq> {
		helpmsg <For generic Quest help, type Help.|n|n|bFAQ|n------|xb|n|n|bQ: Why doesn't x command work?|xb|nA: To simplify the game, all actions can be performed using the mouse and menu panels. Therefore the only commands are basic ones such as look, examine, speak to, take, north, south etc. To "read" a book, simply examine it.|n|n|bQ: SPOILER WARNING: How do I use the teleporter?|xb|nA: The teleporter is made up of two parts - the booth and the GPT. You can carry the GPT around with you. If you use the GPT, it will be dropped in the room you are in and you will be teleported back to the booth. If you take the booth, you will teleport to the same room as the GPT. In this way, you can quickly leap to and from the laboratory used for making potions.|n>
		helpmsg <|bQ: SPOILER WARNING: How do I make a potion?|xb|nUse the red potion, blue potion and yellow potion on the flask, in any order. Then use the full flask on the Hydroscope or Plasma Reactor. You can only use each ingredient once per potion. This provides 12 different potions you can make. To find out what they do, look at the blackboard in the lab - or just experiment! You have an unlimited amount of red, blue and yellow liquids and you can tip away a finished potion at any time.|n|n|bQ: SPOILER WARNING: How do I solve the puzzle I'm stuck on?|xb|nThink logically. You're never going to have to do anything ridiculous like using a stuffed alligator to unlock a car door. Pick up everything you can. You never know when something might come in handy, so hold on to anything useful. Some puzzles have more than one way to solve them. If in doubt, try using a potion. You can make all sorts of useful potions to solve puzzles.>
		helpmsg <|bQ: SPOILER WARNING: I ran out of bullets - does this mean I can't complete the game?|xb|nAs far as I know there is no way to "break" the game or get stuck in an unwinnable situation. Using up all your bullets may limit your options though.>
	}
	error <badthing; That object doesn't exist.>
	error <badplace; That room doesn't exist.>
	error <itemunwanted; #quest.error.gender# can't be given #quest.error.article#.>
	error <defaultuse; You can't do anything with that on it's own.>
	error <cantdrop; You'd better not leave that just lying around.>
	error <noitem; You don't have that item.>
	error <badtake; It's not possible to pick #quest.error.article# up.>
	error <baditem; That's not an object in the current room.>
	error <baddrop; You could drop that - if you had it.>
	error <defaultdrop; You put #quest.error.article# on the floor.>
	error <defaultexamine; I can't see anything special about it.>
	error <defaultlook; There's not much to see.>
	error <defaultspeak; It's an inanimate object and cannot talk.>
	define variable <Machine Gun Ammunition>
		type numeric
		value <0>
		display nozero <Ammunition: !>
	end define
end define

define synonyms
end define

define room <Darkness>
	alias <darkness>
	look <You can hear a faint roaring sound but the bag on your head is muffling sound. Your hands are bound but you can feel the seat you are in.>
	indescription <You are in total:>

	define object <Shape>
		alias <shape>
		look <You can't look at it, you've got a bag on your head.>
		take {
			msg <You slip the object into your palm. Now that you can feel it in your hand, you can tell it is definitely a paper clip.>
			hide <Shape>
			show <Paper Clip>
			give <Paper Clip>
		}
		speak <You've been gagged, but you doubt the object could reply anyway.>
		examine <You feel the shape. It feels like something made of wire, perhaps a paper clip.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Paper Clip>
		alias <Paper Clip>
		alt <clip>
		look <You can't see it, you're blindfolded.>
		speak <It doesn't reply.>
		examine <You can bend it into shapes.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use on <Handcuffs> {
			msg <You slot the paper clip into the narrow lock on the handcuffs. After some wriggling, you feel it catch. The handcuffs loosen, then swing open. You are free. You are about to tear the hood from your head when someone else does it for you. You realise you are in a helicopter! You could be anywhere! Solidly built men man-handle you out of the craft and across a small hangar. Before you know it, you have been deposited in a dull prison cell with little hope of rescue. Still, at least you're free from your handcuffs...>
			wait <Press any key when ready.>
			goto <Cell3>
			hide <Paper Clip>
			hide <Handcuffs>
		}
		drop nowhere <It really wouldn't be a good idea to drop your only chance of escape!>
	end define

	define object <Handcuffs>
		alias <Handcuffs>
		alt <cuffs>
		look <You can't see them for the bag on your head, but they're tight and digging into your wrists.>
		speak <The handcuffs aren't very conversational.>
		examine <You can feel the cuffs if you twist your fingers around. They're cold metal and very solid. There's no way of just pulling them off.>
		prefix <a pair of>
		article <them>
		gender <it>
		drop nowhere <The handcuffs are firmly attached to you; there's no way of just dropping them.>
	end define

end define

define room <Cell2>
	alias <cell>
	look <This cell is much the same as your own. The paint is peeling slightly less, and this cell isn't occupied, but those are the only differences.>
	indescription <You are in the cell to the west of your own.>
	north msg <You can't leave the cell that easily!>
	east <Cell3>
	script if got <Cot> then {
		move <Cot; Cell3>
		msg <You are forced to drop the cot before crawling through the narrow duct.>
	}

	define object <Door2>
		alias <Cell door>
		alt <bars; door; guard>
		look <It's a heavy metal door with a barred slot in it. The slot is sealed with plexiglass. You can make out an armed guard beyond the door.>
		take msg <You attempt to pull the door off it's hinges but your feeble human physiology means you fail miserably.>
		speak {
			msg <You shout to the guard but he doesn't respond. After some more shouting, he turns to you and cocks his gun. You start to wonder if continuing to shout might not be such a good idea. Just as you shut up however, a different sound starts up - a loud alarm starts blaring. The guard looks around worried. He gets on the radio and asks what the hell's going on. Before he can get a reply, you can see the faint haze of gas shimmering into the room. The guard's look of angry bewilderment dissolves into pain and terror and he clutches ineffectually at his throat. After barely three seconds, he keels over; his eyes roll back in his skull.>
			wait <Press any key when ready...>
			msg <You stare at the guard's corpse, and panic momentarily that you're next. But no gas comes. The cells must be on a different air purificaton system. Given the security issue, it probably wouldn't be in the building's schematics to have air vents leading from prison cells out into the corridor. Presently, a white cloud of gas sprays from the ceiling, presumably to cleanse the corridor. After the gas has cleared, something you really werent expecting happens - with a buzz, the cell door swings  open.>
			hide <Door>
			hide <Door2>
			create exit north <Cell; PrisonEndCorridor2>
			create exit north <Cell2; PrisonEndCorridor>
		}
		examine <The guard behind the door is wearing kevlar and carrying a very advanced-looking automatic weapon. >
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Laser Forcefield3>
		alias <Laser Forcefield>
		alt <laser; forcefield; field>
		look <It looks like a sheet of smokey light hovering a few feet away from the cell door. It's completely impassable.>
		take msg <Touching the forcefield merely increases it's humming noise; you can't move it.>
		speak <It hums slightly but doesn't talk.>
		examine <It's coming from a projector built into the wall. It continues through a thin slot into the cell next door. A warning label on the emitter states that overworking the forcefield may cause it to short circuit.>
		prefix <a high-tech>
		article <it>
		gender <it>
	end define

	define object <Laser Forcefield4>
		alias <Laser Forcefield>
		alt <laser; forcefield; field>
		look <It looks like a sheet of smokey light hovering a few feet away from the cell door. It's completely impassable. There's a cot leaning on it.>
		take msg <Touching the forcefield merely increases it's humming noise; you can't move it. The cot's doing a fine job, no point taking that.>
		speak <It hums slightly but doesn't talk.>
		examine <It's coming from a projector built into the wall. It continues through a thin slot into the cell next door. A warning label on the emitter states that overworking the forcefield may cause it to short circuit. You're currently overworking it by leaning a cot on it.>
		prefix <a high-tech>
		article <it>
		gender <it>
		hidden
	end define

	define object <Cot2>
		alias <cot>
		alt <bed>
		look <It's a bare steel cot.>
		take {
			msg <You pick up the metal-framed bed. It'll be too big to take out of the room but you can lug it around in here all you want.>
			give <Cot2>
		}
		speak <It doesn't speak.>
		examine <Your captors have neglected to even put a mattress on the damn thing - it'd be more comfortable sleeping on the floor. It looks quite heavy, but light enough to pick up.>
		prefix <a>
		article <it>
		gender <it>
		use on <Laser Forcefield3> {
			msg <You lean the relatively heavy cot on the forcefield. This obviously puts some strain on the forcefield as the humming increases significantly.>
			hide <Cot2>
			hide <Laser Forcefield3>
			show <Laser Forcefield4>
			if exists <Laser Forcefield4> and exists <Laser Forcefield2> then {
				msg <The combined force of both cots leaning on the laser forcefield causes it to short out with a small bang. That's state of the art for you.>
				hide <Laser Forcefield4>
				hide <Laser Forcefield2>
				show <Door2>
				show <Door>
			}
			else msg <The cot is straining the forcefield, but not enough to break it.>
		}
		drop everywhere <You drop the cot and it clatters to the floor.>
	end define

end define

define room <PrisonEndCorridor>
	alias <Corridor>
	look <The floor here is checked tiles. Several are missing, revealing the dull concrete beneath. A fluorescent flickers overhead.|n|nSouth lies a prison cell, now open. To the east the corridor continues.>
	indescription <You are standing at the end of a short:>
	south <Cell2>
	east <PrisonEndCorridor2>

	define object <Dead Guard>
		alias <Dead guard>
		alt <guard; body; stiff; corpse>
		look <He's quite dead. There's now a small trickle of blood running from his nose.>
		take msg <He's quite a well-built man wearing full body armour. You can't carry him.>
		speak <You could spout some cheesily ironic catchphrase, but you're not really in the mood.>
		examine <The insignia on his body armour isn't clear but you think he was quite high-ranking, for a guard.>
		prefix <the>
		article <them>
		gender <he>
		use <Knife> msg <The knife is far too blunt to cut anything on the guard.>
	end define

	define object <Machine Gun>
		alias <Machine Gun>
		alt <gun; weapon>
		look <It's a metal instrument of death with quite a few LED displays.>
		take {
			msg <You lift the surprisingly light machine gun. It's fully loaded.>
			set numeric <Machine Gun Ammunition; 50>
			give <Machine Gun>
		}
		speak <Talking to your gun really isn't macho.>
		examine <It could be an OICW. You can't remember what that stands for but it was in a computer game and looked a bit like this gun.>
		prefix <a>
		article <it>
		gender <it>
		use msg <It's not that bad - you don't need to shoot yourself.>
		use anything msg <You can't load that into the gun.>
		use on anything msg <Shooting that won't help matters.>
		drop nowhere <This gun could come in very useful. You'd better not leave it.>
	end define

	define object <Finger>
		alias <Severed Finger>
		alt <finger>
		look <This grisly trophy of your cell guard is turning grey.>
		take <You pocket the limp digit.>
		speak <What would it say?>
		examine <The fingerprint is nice and clear and the blood has coagulated.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <I don't want to know what you were planning to do with that...>
		use on anything msg <A severed digit is no use there.>
		drop nowhere <You've got a feeling this grisly trophy may be worth hanging onto.>
	end define

	define object <Dead Guard2>
		alias <Dead guard>
		alt <guard; body; stiff; corpse>
		look <He's quite dead. There's now a small trickle of blood running from his nose. One of his fingers has been lopped off.>
		take msg <He's quite a well-built man wearing full body armour. You can't carry him.>
		speak <You could spout some cheesily ironic catchphrase, but you're not really in the mood.>
		examine <The insignia on his body armour isn't clear but you think he was quite high-ranking, for a guard.>
		prefix <the>
		article <them>
		gender <he>
		hidden
		use <Pruning Shears> msg <You see no reason to further mutilate the corpse.>
		use <Knife> msg <The knife is too blunt to have any effect on the corpse.>
	end define

end define

define room <PrisonEndCorridor2>
	alias <Corridor>
	look <The floor here is checked tiles. Several are missing, revealing the dull concrete beneath. A fluorescent flickers overhead.|n|nSouth lies your prison cell. The corridor runs to it's end west of here. A door lies north.>
	indescription <You are standing in a short:>
	north <Guard House>
	west <PrisonEndCorridor>
end define

define room <Guard House>
	alias <Guardhouse>
	look <A game of cards is spread across the room's one table. A vending machine hums in the corner. This is a room of basic needs; the guards on this shift must get extremely bored. Or at least, they would have, when they were alive - two more corpses lie strewn across the table.|n|nA door leads south to the cells.|nA blood-stained door leads west.|nA large metal door leads east. A fingerprint scanner sits next to it.>
	indescription <You are in a lived-in:>
	south <PrisonEndCorridor2>
	east msg <The metal door to the east is securely locked. Only the fingerprint scanner can open it.>
	west <Interrogation Chamber>

	define object <Fingerprint Scanner>
		alias <Fingerprint Scanner>
		alt <print scanner; scanner>
		look <It's a texture-sensitive screen that scans fingerprints. You'll need the right fingerprint to open the door to the east.>
		take msg <That's bolted to the wall.>
		speak <It's not a voice recognition scanner!>
		examine <It's all ready to go, you just need a valid fingerprint.>
		prefix <a>
		article <it>
		gender <it>
		use <Finger> {
			msg <You press the severed digit to the pad of the scanner. The scanner flashes across the print, processes the data, then turns green and unlocks the large metal door to the east.>
			create exit east <Guard House; Hangar>
		}
	end define

	define object <Card Table>
		alias <Card Table>
		alt <table>
		look <A round table with a game of cards spread over it. There are two corpses leaned over it.>
		take msg <There's nothing worth picking up.>
		speak <The table could never talk, and the guards can't now.>
		examine if flag <readreport> then {
			if exists <Hard Drive> or exists <Computer Case3> then msg <All the cards are face down except for the ace of clubs, the three of diamonds, the seven of spades and the king of hearts. You can't see anything of importance on the guards.> else {
				msg <You search the pockets of the guards. One of them is carrying a Hard Drive! You take it off him; he won't be needing it.>
				show <Hard Drive>
				give <Hard Drive>
			}
		}
		else msg <All the cards are face down except for the ace of clubs, the three of diamonds, the seven of spades and the king of hearts. You can't see anything of importance on the guards.>
	end define

	define object <Hard Drive>
		alias <Hard Drive>
		alt <drive; hd>
		look <It's a computer's hard drive, used for storing data.>
		take <You carefully pick up the Hard Drive in it's static-proof bag.>
		examine <The Hard Drive has a label on it stating that it is from Security Computer B.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <It's useless without other computer components.>
		use anything msg <You can't plug that into the hard drive like that.>
		use on anything msg <You can't plug the hard drive into just anything!>
		drop nowhere <This is fragile and valuable - better not leave it lying around!>
	end define

	define object <Security Map 001>
		alias <Security Map 001>
		alt <map 001; map 1>
		look picture <map1.jpg>
		take <You pick up the tattered map.>
		speak <It doesn't talk.>
		examine <If you want to view the map, just look at it.>
		prefix <a copy of>
		article <it>
		gender <it>
		use picture <map1.jpg>
		use anything msg <You can't use that on the map.>
		use on anything msg <How is that going to achieve anything?>
		drop nowhere <You'd better not lose your map.>
	end define

end define

define room <Interrogation Chamber>
	alias <Interrogation Chamber>
	look <This room has obviously seen a lot of suffering. A large chair is bolted to the floor in the centre of the room. It has leather straps on the arms and legs and one at the top of the chair. Blood spots mar the floor and evil instruments of torture line the walls.>
	indescription <You are in a grubby: >
	east <Guard House>

	define object <Pruning Shears>
		alias <Pruning Shears>
		alt <shears>
		look <You doubt these shears have ever been used for pruning roses.>
		take <You gingerly pick up the evil instrument of torture.>
		speak <It's inanimate and cannot speak.>
		examine <Blood has dried and cracked all over the blades. The safety catch has snapped.>
		prefix <a pair of>
		article <them>
		gender <it>
		use on <Dead Guard> {
			msg <You deftly snip the finger from the guard's right hand. This may come in handy.>
			show <Finger>
			give <Finger>
			hide <Dead Guard>
			show <Dead Guard2>
		}
		use on anything msg <You can't just cut anything up with those things.>
		drop nowhere <You never know when these might come in handy. Best hold onto them.>
	end define

	define object <Torture Chair>
		alias <Torture Chair>
		alt <chair>
		look <It's padded - probably the only comfort the occupant gets.>
		take msg <It's bolted to the floor.>
		speak <It has borne witness to who knows what atrocities, but it will never tell.>
		examine <At first glance it appears dull brown, but it was once white - the discolouring appears to be from years of blood spilt on it. Was this to be your fate?>
		prefix <the>
		article <it>
		gender <it>
	end define

	define object <Knife>
		alias <Knife>
		look <It's a fairly blunt, but thick and sturdy knife. It's stained brownish-red.>
		take <You pick up the blood-stained knife.>
		examine <The tip is quite sharp but most of the length of the blade is dull and blunted. You couldn't do much damage with it except as a blunt instrument.>
		prefix <a>
		article <it>
		gender <it>
		drop nowhere <This knife could be useful. You should keep hold of it.>
	end define

end define

define room <Hangar>
	alias <Hangar>
	look <The roof of this cave is a huge pair of sliding doors to allow a helicopter to fly down into the room. The centre of the room contains a large helipad. There is no helicopter occupying it at the present.>
	indescription <You find yourself in a small:>
	north <Cafeteria>
	south <Long corridor>
	east msg <The large door to the east is firmly shut and security locked. Perhaps the stripped-down computer in the wall has something to do with opening it.>
	west <Guard House>

	define object <Computer Case>
		alias <Computer Case>
		alt <computer; case>
		look <It's a PC case built into a panel in the wall next to the large security door to the east. The cover is missing and all the components have been removed. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't talk.>
		examine <It looks like the computer controls the door mechanism. If you had all the parts, you could presumably open the door.>
		prefix <an empty>
		article <it>
		gender <it>
		use <Motherboard3> if flag <readmanual> then {
			msg <You clip the motherboard into place in the case, connect the power supply and fans and wire up the power switch.>
			hide <Motherboard3>
			hide <Computer Case>
			show <Computer Case2>
		}
		else msg <It must go in somehow, but you don't know how exactly.>
		use <Motherboard2> msg <That doesn't go into there yet.>
		use <Motherboard> msg <That doesn't go into there yet.>
		use <Panel> msg <All the components are missing. There's no point fitting that yet.>
		use <RAM> msg <That doesn't go in there like that.>
		use <Hard Drive> msg <That doesn't go in there like that.>
		use <Processor> msg <That doesn't go in there like that.>
		use anything msg <You can't put that in like that.>
	end define

	define object <Panel>
		alias <Panel>
		alt <switch; button; card scanner; scanner; security card scanner>
		look <It's a metal panel with a large security card scanner on the front.>
		take <You pick up the metal panel.>
		speak <It doesn't say a word.>
		examine <It looks like the side of a PC case. Wires protude from the back of the security card scanner.>
		prefix <a>
		article <it>
		gender <it>
		use msg <It needs the rest of the computer before it'll work.>
		use on anything msg <It doesn't slot onto that.>
	end define

	define object <Computer Case2>
		alias <Computer Case>
		alt <computer; case>
		look <It's a PC case built into a panel in the wall next to the large security door to the east. The cover is missing but a motherboard with processor and RAM has been installed. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't talk.>
		examine <It looks like the computer controls the door mechanism. If you had all the parts, you could presumably open the door.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Hard Drive> if flag <readmanual> then {
			msg <You wire up the Hard Drive correctly and slide it into place.>
			hide <Hard Drive>
			hide <Computer Case2>
			show <Computer Case3>
		}
		else msg <You don't know how that would install.>
		use <Panel> msg <Not all the components are fitted yet. Fitting the panel would be a pointless endeavour at this stage.>
		use anything msg <You can't put that in like that.>
	end define

	define object <Computer Case3>
		alias <Computer Case>
		alt <computer; case>
		look <It's a PC case built into a panel in the wall next to the large security door to the east. The cover is missing but a motherboard with processor and RAM, and a Hard Drive have been installed correctly. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't talk.>
		examine <It looks like the computer controls the door mechanism. If you had all the parts, you could presumably open the door.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Panel> {
			msg <You slot the case panel back into place after wiring the Security scanner up to the internal components.>
			hide <Panel>
			show <Computer>
			move <Computer Case3; Objects>
		}
		use anything msg <You can't put that in like that.>
	end define

	define object <Computer>
		alias <Computer>
		alt <panel; security card scanner; card scanner; scanner>
		look <With the panel in place, all you can see is the security card reader and the power switch. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't speak.>
		examine choose <Turn on PC>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <You can't manipulate the computer with that.>
	end define

	define object <badComputer>
		alias <Computer>
		alt <panel; security card scanner; card scanner; scanner>
		look <With the panel in place, all you can see is the security card reader and the power switch. The computer is turned on. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't speak.>
		examine choose <Turn Off PC>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Test Card> msg <You swipe the test card through the scanner. With a beep, the computer rejects the card.>
		use anything msg <You can't manipulate the computer with that.>
	end define

	define object <goodComputer>
		alias <Computer>
		alt <panel; security card scanner; card scanner; scanner>
		look <With the panel in place, all you can see is the security card reader and the power switch. The computer is turned on and in Safe Mode. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't speak.>
		examine choose <Turn Off PC>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <You can't manipulate the computer with that.>
	end define

	define object <goodComputer2>
		alias <Computer>
		alt <panel; security card scanner; card scanner; scanner>
		look <With the panel in place, all you can see is the security card reader and the power switch. The computer is turned on and in Safe Mode. An attached touchscreen monitor is built into the wall above it.>
		take msg <It's built into the wall, and connected to who knows what electrical circuits in the wall - removing it without a bulldozer would be tricky.>
		speak <It can't speak.>
		examine msg <The door is open. There's nothing more you can do with the computer.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <You can't manipulate the computer with that.>
	end define

end define

define room <Cell3>
	alias <cell>
	look <This drab grey cell has no windows and no light, save for the glow given off from a laser forcefield and a thin sliver of light shining through a barred slot in the heavy iron door.>
	indescription <You are in a dank, bare prison: >
	north msg <You can't leave your cell that easily!>
	script if got <Cot2> then {
		move <Cot2; Cell2>
		msg <You are forced to drop the cot before crawling through the air duct.>
	}

	define object <Cot>
		alias <cot>
		alt <bed>
		look <It's a bare steel cot.>
		take {
			msg <You pick up the flimsy metal-framed bed. It'll be too big to take out of the room but you can lug it around in here all you want. Moving the cot revealing a small grille in the wall...>
			show <Grille>
			give <Cot>
		}
		speak <It's your only companion, but still, it doesn't speak.>
		examine <Your captors have neglected to even put a mattress on the damn thing - it'd be more comfortable sleeping on the floor. It looks quite heavy, but light enough to pick up.>
		prefix <a>
		article <it>
		gender <it>
		use on <Laser Forcefield> {
			msg <You lean the relatively heavy cot on the forcefield. This obviously puts some strain on the forcefield as the humming increases significantly.>
			hide <Cot>
			hide <Laser Forcefield>
			show <Laser Forcefield2>
			if exists <Laser Forcefield4> and exists <Laser Forcefield2> then {
				msg <The combined force of both cots leaning on the laser forcefield causes it to short out with a small bang. That's state of the art for you.>
				hide <Laser Forcefield4>
				hide <Laser Forcefield2>
				show <Door2>
				show <Door>
			}
			else msg <The cot is straining the forcefield, but not enough to break it.>
		}
		drop everywhere <You drop the cot and it clatters to the floor.>
	end define

	define object <Grille>
		alias <grille>
		look <This grille is covering a ventilation shaft. It's firmly screwed to the wall.>
		take msg <You tug at the grille but it's screwed in tight. There's no way you can remove it with your bare hands.>
		speak <Your voice echoes through the ventilation shaft behind the grille.>
		examine <You could unscrew it if you had anything vaguely resembling a screwdriver.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Dinner>
		alias <dinner>
		alt <food; gruel>
		look <It's grey and sludgy. And cold. And those are it's good points.>
		take msg <You could take that, but it'd really mess up your pockets. If you're still stuck in here in a week, you |imight|xi consider eating it.>
		speak <Give it a few weeks and there might be enough life here to strike up a conversation with...>
		examine <You sift through the goop in the hopes of finding a key or a message or something, but all you find is more goop and what might be rat droppings.>
		prefix <your>
		article <it>
		gender <it>
	end define

	define object <Fork>
		alias <fork>
		look <It's a plastic fork. Presumably metal is too dangerous to give to prisoners.>
		take <You pick up the one halfway useful part of your dinner.>
		speak <It's a fork - it can't talk.>
		examine <It looks quite sturdy. The handle is narrow.>
		prefix <a>
		article <it>
		gender <it>
		use msg <What do you want to do, poke yourself in the eye?>
		use on <Grille> {
			msg <You very carefully use the fork handle to prise the screws loose. Soon you have removed the grille and can see into the next cell through a small duct.|n|nYou can now crawl WEST into the next cell.>
			create exit west <Cell3; Cell2>
			hide <Grille>
		}
		use on anything msg <You can't eat that with a fork!>
	end define

	define object <Door>
		alias <Cell door>
		alt <bars; door>
		look <It's a heavy metal door with a barred slot in it. The slot is sealed with plexiglass.>
		take msg <You attempt to pull the door off it's hinges but your feeble human physiology means you fail miserably.>
		speak <It responds with steely silence.>
		examine <No, you can't lift it off the hinges. It's slightly more secure than that.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Laser Forcefield>
		alias <Laser Forcefield>
		alt <laser; forcefield; field>
		look <It looks like a sheet of smokey light hovering a few feet away from the cell door. It's completely impassable.>
		take msg <Touching the forcefield merely increases it's humming noise; you can't move it.>
		speak <It hums slightly but doesn't talk.>
		examine <It's coming from a projector built into the wall. It continues through a thin slot into the cell next door. A warning label on the emitter states that overworking the forcefield may cause it to short circuit.>
		prefix <a high-tech>
		article <it>
		gender <it>
	end define

	define object <Laser Forcefield2>
		alias <Laser Forcefield>
		alt <laser; forcefield; field>
		look <It looks like a sheet of smokey light hovering a few feet away from the cell door. It's completely impassable. There's a cot leaning on it.>
		take msg <Touching the forcefield merely increases it's humming noise; you can't move it. The cot's doing a fine job, no point taking that.>
		speak <It hums slightly but doesn't talk.>
		examine <It's coming from a projector built into the wall. It continues through a thin slot into the cell next door. A warning label on the emitter states that overworking the forcefield may cause it to short circuit. You're currently overworking it by leaning a cot on it.>
		prefix <a high-tech>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Long corridor>
	alias <Long corridor>
	look <This corridor ran straight south for quite a way. A sign on the wall gives directions: the Hangar is north, the Technical Department is south.>
	indescription <You are standing in a straight: >
	north <Hangar>
	south <Workshop>
end define

define room <Workshop>
	alias <Workshop>
	look <This room has bright fluorescent lights hung low on chains over several messy desks. Various computer components lie strewn about the place and there is a faint smell of burning.>
	indescription <You are in the Technical department's: >
	north <Long corridor>
	east <Storeroom>
	west msg <The door to the west is a heavy metal security door. There's no way of opening it without proper authorisation.>

	define object <Report>
		alias <Report>
		alt <note; paper>
		look <It's a report on a computer repair.>
		take <You pick up the report.>
		speak <It can't speak.>
		examine {
			msg <You read the report:|n|nSecurity Computer B Repair Report|n---|nThe damaged security card has shorted out most of the internal components. Luckily the Hard Drive and all software is undamaged, but the motherboard, processor and RAM all need replacing. I'll replace the components after lunch.|n|nNote to self: boot in safe mode to test security scanner without the need for a valid card. Oh, and I've left the Hard Drive with Bill, the security guard in the detention centre, for safe keeping.>
			flag on <readreport>
		}
		prefix <a>
		article <it>
		gender <it>
		drop everywhere <You drop the computer report and it floats to the ground.>
	end define

	define object <Manual>
		alias <Manual>
		alt <book; instructions>
		look <It's a motherboard instruction manual. It's got clear instructions for putting together a PC.>
		take <You pick up the manual. This could be useful.>
		speak <It contains a lot of information, but it can't speak any of it!>
		examine {
			msg <Installation of components|n---|n|nProcessor - Install this first. Lift up the clip on the motherboard (see Diagram A). Slot the processor in place, ensuring that the rounded corner lines up with the corresponding corner on the motherboard. Carefully push into place and secure with the clip.|n|nRAM - Once the processor is installed, slot the RAM into the spaces marked in diagram B. The RAM will only fit one way round, so ensure that the clips are able to clip firmly into place.|n|nCase Installation - Now screw the motherboard into the case and connect the power supply and fans as shown in diagram C.|n|nHard Drive - Screw the Hard Drive into the correct slot in your case, then connect the IDE cable to the corresponding Master slot on the motherboard (See diagram D).>
			flag on <readmanual>
		}
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Motherboard>
		alias <Motherboard>
		alt <mainboard; board>
		look <It's a large, fully functional motherboard.>
		take <You pick up the board.>
		speak <It says nothing.>
		examine <It appears to be in working order. No components are attached to it.>
		prefix <a>
		article <it>
		gender <it>
		use <Processor> if flag <readmanual> then {
			msg <You carefully slot the processor chip into the correct slot on the motherboard.>
			hide <Processor>
			hide <Motherboard>
			show <Motherboard2>
			give <Motherboard2>
		}
		else msg <You're sure it fits somehow but you don't know exactly how to install it.>
		use <RAM> if flag <readmanual> then msg <The manual didn't say to install the RAM at this stage. It would be best to follow the instructions carefully.> else msg <You've no idea how to install that.>
		use <Hard Drive> msg <There's nowhere for it to slot into.>
		use <Panel> msg <The panel doesn't connect to the motherboard like that.>
		use anything msg <You can't plug anything into it.>
		use on anything msg <You can't screw the motherboard to that.>
		drop nowhere <That's too important to just leave around.>
	end define

	define object <Motherboard2>
		alias <Motherboard>
		alt <mainboard; board>
		look <It's a large, fully functional motherboard.>
		take <You pick up the board.>
		speak <It says nothing.>
		examine <It appears to be in working order. A processor is slotted in correctly.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <RAM> if flag <readmanual> then {
			msg <You slot the two sticks of RAM into the motherboard correctly.>
			hide <RAM>
			hide <Motherboard2>
			show <Motherboard3>
			give <Motherboard3>
		}
		else msg <There must be a way to install the memory, but you don't know how.>
		use <Hard Drive> msg <There's nowhere for it to slot into.>
		use <Panel> msg <The panel doesn't connect to the motherboard like that.>
		use anything msg <You can't plug anything into it.>
		use on anything msg <You can't screw the motherboard to that.>
		drop nowhere <That's too important to just leave around.>
	end define

	define object <Motherboard3>
		alias <Motherboard>
		alt <mainboard; board>
		look <It's a large, fully functional motherboard.>
		take <You pick up the board.>
		speak <It says nothing.>
		examine <It appears to be in working order. A processor and two sticks of RAM are slotted in correctly.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Panel> msg <The panel doesn't connect to the motherboard like that.>
		use anything msg <You can't plug anything into it.>
		use on anything msg <You can't screw the motherboard to that.>
		drop nowhere <That's too important to just leave around.>
	end define

	define object <Security Door>
		alias <Security Door>
		alt <door>
		look <This door leads west. But it's shut, and only the proper authorisation or some extreme force will shift it.>
		take if flag <playerstrong> then {
			msg <With the effects of the strength potion activated, you tear the metal door open, allowing access to the room to the west.>
			create exit west <Workshop; Area C Control Room>
			hide <Security Door>
		}
		else msg <You can't just wrench the door off it's hinges, it's virtually immovable.>
		speak <It doesn't speak.>
		examine if flag <playerstrong> then {
			msg <It's made of thick steel. It's virtually immovable. With your super strength, however, you manage to bend the metal and tear the door open, allowing access to the room to the west.>
			hide <Security Door>
			create exit west <Workshop; Area C Control Room>
		}
		else msg <It's made of thick steel. It's virtually immovable.>
		prefix <a>
		article <it>
		gender <it>
		use <BeakerYRB2> {
			msg <You throw the volatile cocktail across the room at the security door. Upon impact, the liquid explodes in a small but ferociously powerful fireball. A heat wave washes over you, and you see that the security door has been blown into shreds.>
			hide <Security Door>
			hide <BeakerYRB2>
			show <Beaker>
			give <Beaker>
			create exit west <Workshop; Area C Control Room>
		}
		use anything msg <You won't break through the door like that.>
	end define

end define

define room <Storeroom>
	alias <Store Room>
	look <Boxes of computer components are stacked high on the shelves of this small store room. A few boxes seem to have been recently opened.>
	indescription <This is the workshop: >
	west <Workshop>

	define object <RAM>
		alias <RAM>
		alt <random access memory; memory>
		look <Two sticks of 256Mb of RAM, totally 512Mb.>
		take <You pick up the two sticks of memory and pocket them.>
		speak <They can't talk.>
		examine <These components seem to be in perfect working order.>
		prefix <two sticks of>
		article <them>
		gender <it>
		use on anything msg <That doesn't go in there like that.>
		drop nowhere <This is fragile and valuable - better not leave it lying around!>
	end define

	define object <Locked Cupboard>
		alias <Locker>
		alt <locked cupboard; metal locker; cupboard; locked locker>
		look <It's a metal locker. It appears to be locked.>
		take msg <It's too heavy to lift.>
		speak <It doesn't reply.>
		examine <It looks like it's going to be impossible to open without a key.>
		prefix <a>
		article <it>
		gender <it>
		use <Machine Gun> {
			msg <You take aim, and very briefly pull the trigger. With a loud crack, the weapon discharges and blows the lock away. The door swings forlornly open. Who says violence never solves anything?>
			hide <Locked Cupboard>
			show <Locked Cupboard2>
			dec <Machine Gun Ammunition; 1>
		}
		use <Locker Key> {
			msg <You try the key and it fits, allowing you to open the locker.>
			hide <Locker Key>
			hide <Locked Cupboard>
			show <Locked Cupboard4>
		}
		use anything msg <That won't open the locker.>
	end define

	define object <Locked Cupboard2>
		alias <Locker>
		alt <locked cupboard; metal locker; cupboard; locked locker>
		look <It's a metal locker. The door is hanging off it's hinges. There is a large round hole where the lock used to be.>
		take msg <It's too heavy to lift.>
		speak <It doesn't reply.>
		examine choose <Retrieve processor from locker>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <There's nothing more you can do to the locker.>
	end define

	define object <Processor>
		alias <Processor>
		alt <chip>
		look <It's a processor chip. The label says it's a 2Ghz Pentium.>
		take <You pick up the processor.>
		speak <It can't speak.>
		examine <It's in perfect condition - brand new.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use on anything msg <You can't plug the processor into that like that.>
		drop nowhere <This is fragile and valuable - better not leave it lying around!>
	end define

	define object <Locked Cupboard3>
		alias <Locker>
		alt <locked cupboard; metal locker; cupboard; locked locker>
		look <It's a metal locker.>
		take msg <It's too heavy to lift.>
		speak <It doesn't reply.>
		examine <You've already taken a processor from the locker. There's nothing else of interest.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <There's nothing left to do to the cupboard - you've retreived the contents.>
	end define

	define object <Locked Cupboard4>
		alias <Locker>
		alt <locked cupboard; metal locker; cupboard; locked locker>
		look <It's a metal locker. The door is unlocked and open.>
		take msg <It's too heavy to lift.>
		speak <It doesn't reply.>
		examine choose <Retrieve processor from locker>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <You can't do anything else to the locker, it's already unlocked.>
	end define

	define object <Blank Card>
		alias <Blank Card>
		alt <card; security card>
		look <This is an unencoded security card. It's got a blank magnetic strip on the back but no data has been written to it.>
		take <You pick up the blank card.>
		examine <It's shiny and plastic, but useless without any data on it.>
		prefix <a>
		article <it>
		gender <it>
		use on <Magnetic Encoder2> {
			msg <You insert the blank card into the magnetic encoder and write the security data to it. You now have a high-clearance security card.>
			hide <Blank Card>
			show <writtencard>
			give <writtencard>
		}
	end define

	define object <writtencard>
		alias <Security Card>
		alt <card; magnetic card>
		look <This is an encoded security card. It's got a magnetic strip on the back containing high level security codes.>
		take <You pick up the card.>
		examine <It's security clearances can be used to access Area A.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Objects>
	alias <Objects>
	look <Not a real room - just a place to dump objects.>
end define

define room <Reception>
	alias <Reception>
	look <This plush office reception boasts a shiny round reception desk and several pot plants. A receptionist is slumped dead over her keyboard.>
	indescription <You are in a room used for: >
	north <Labnorth>
	south <Labsouth>
	east <Hall>
	west <Hangar>

	define object <Reception Desk>
		alias <Reception Desk>
		alt <reception; desk>
		look <It's shiny and curved. There's a security monitor at one end of it, and a dead receptionist slumped over her keyboard.>
		take msg <The desk is far too heavy to lift.>
		speak <There is no answer.>
		examine <There's nothing of any use on or around the desk.>
		prefix <the>
		article <it>
		gender <it>
		use anything msg <There's nothing on the desk that you can use that on.>
	end define

	define object <Security Monitor>
		alias <Security Monitor>
		alt <monitor; screen>
		look <It's currently showing a fascinating display of white noise and nothing else.>
		take msg <It's a bit too big and unwieldy to carry around.>
		speak <It doesn't have sound.>
		examine <You hit the rewind button to see the last activity on the tape. The screen shows a scientist carefully mixing certain chemicals in a beaker. He occasionally makes notes on a clipboard. Presently, another man enters with a hypodermic needle in a case.|nThe scientist accepts the delivery and begins testing the liquid in the needle. Suddenly, one of his experiments starts billowing clouds of gas. The scientist clutches his throat then dies. The gas rises to cover the whole screen and the tape cuts out.|n|nWell that explains why everyone is dead.>
		prefix <a>
		article <it>
		gender <it>
		use anything msg <You can work the security monitor fine without that.>
	end define

	define object <Security Computer>
		alias <Security Computer>
		alt <computer>
		look <The computer is used for writing security data in magnetic format. A USB electromagnetic data burner is attached.>
		take msg <It's a bit heavy to be carrying around with you.>
		examine <Some sort of device needs to be inserted into the data burner for it to work.>
		prefix <a>
		article <it>
		gender <it>
		use <Magnetic Encoder> {
			msg <You plug the magnetic encoder into the electromagnetic burner on the computer. The computer automatically loads the software and gives you some options.>
			wait <Press any key...>
			choose <magnetic encoding>
		}
	end define

	define object <Security Computer2>
		alias <Security Computer>
		alt <computer>
		look <The computer is used for writing security data in magnetic format. A USB electromagnetic data burner is attached.>
		take msg <It's a bit heavy to be carrying around with you.>
		examine <You have already burned data to the magnetic encoder, there's nothing else you can do on this computer.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Magnetic Encoder2>
		alias <Magnetic Encoder>
		alt <Encoder; Coder; Magnet>
		look <This device appears to be able to be used to write magnetic information to security cards.>
		take <You pick up the encoder.>
		examine <It's functional and ready to use and contains a data set that is ready to be written to a security card.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Cafeteria>
	alias <Cafeteria>
	look <This room appears to be where the corporation's employees enjoy their lunch. An extremely obese man is lying dead with his face in a plate of spaghetti bolognaise.>
	indescription <You are in a brightly lit: >
	north <Kitchen>
	south <Hangar>

	define object <Corpse>
		alias <Corpse>
		alt <man; fat man; obese man; body; stiff>
		look <It's the body of a very large man. He appears to have died while engaging in his favourite activity - his face is stuck in his dinner.>
		take msg <He's far too heavy to pick up.>
		speak <He couldn't say anything even if he wanted to.>
		examine {
			msg <You gingerly search his pockets and come across a small locker key.>
			hide <Corpse>
			show <Corpse2>
			show <Locker Key>
			give <Locker Key>
		}
		prefix <a>
		article <it>
		gender <it>
		use anything msg <Please don't deface the corpse.>
	end define

	define object <Corpse2>
		alias <Corpse>
		alt <man; fat man; obese man; body; stiff>
		look <It's the body of a very large man. He appears to have died while engaging in his favourite activity - his face is stuck in his dinner.>
		take msg <He's far too heavy to pick up.>
		speak <He couldn't say anything even if he wanted to.>
		examine msg <You gingerly search his pockets but find nothing more.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use anything msg <Please don't deface the corpse.>
	end define

	define object <Locker Key>
		alias <Locker Key>
		alt <key>
		look <It's a small silver key; it looks like it opens a locker or cupboard.>
		take <You pocket the small key.>
		speak <It can't talk.>
		examine <There's nothing overly special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use on anything msg <That key can't unlock that!>
		drop everywhere <You drop the key and it tinkles to the floor.>
	end define

	define object <Test Card>
		alias <Test Card>
		alt <card>
		look <It's a security card. There's a magnetic strip for use in a card scanner.>
		take <You pocket the security card.>
		speak <It's inanimate.>
		examine <Written on the card is a note explaining that this card is for testing of the security system only and will not normally allow security access.>
		prefix <a>
		article <it>
		gender <it>
		use on <goodComputer> {
			msg <You slide the test card through the card reader. In safe mode, the computer recognises the test card and scans it successfully. The east door slides open with a mechanical rumble.>
			create exit east <Hangar; Reception>
			hide <goodComputer>
			show <goodComputer2>
		}
		use on anything msg <You can't use that to scan the card.>
	end define

end define

define room <Labnorth>
	alias <Laboratory>
	look <This room has several benches covered in bunsen burners, strange chemicals and other scientific equipment.>
	indescription <You find yourself in a high-tech:>
	south <Reception>
	east <Refridgerator>

	define object <Chemical Book>
		alias <Chemical Notes>
		alt <notepaper; notes>
		look <It's a series of scrawled notes about some chemicals.>
		take <You pick up the notes.>
		speak <It does not speak.>
		examine <I have finally finished concocting the third of my all purpose chemical concoctions. This one came out a deep blue colour. Here are my findings:|n|nMixing the chemicals in sequence is very important - adding the chemicals to the mix in different orders produces drastically different results.|nA combination of only two of the chemicals always seems to fizzle out, you need all three in the mix.|nThe Hydroscope in the other lab seems to awaken the effects of the chemicals, while the Plasma Reactor seems to generate different but equally effective results.|n|nI have just received a delivery of the X-Serum, and must begin tests on this immediately. I have stored the three coloured chemicals in the walk-in fridge.>
		prefix <some>
		article <them>
		gender <it>
		use anything msg <You can't do anything to the notepaper with that.>
		use on anything msg <Those notes won't affect that.>
		drop nowhere <These notes contain valuable information. You should hang onto them.>
	end define

	define object <Beaker>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's an empty flask.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		use <Red Chemical> {
			msg <You tip some of the red chemical into the beaker.>
			hide <Beaker>
			show <BeakerR>
			give <BeakerR>
		}
		use <Yellow Chemical> {
			msg <You tip some of the yellow chemical into the beaker.>
			hide <Beaker>
			show <BeakerY>
			give <BeakerY>
		}
		use <Blue Chemical> {
			msg <You tip some of the blue chemical into the beaker.>
			hide <Beaker>
			show <BeakerB>
			give <BeakerB>
		}
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerR>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, one third full of red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Yellow Chemical> {
			msg <You tip some of the yellow chemical into the beaker.>
			hide <BeakerR>
			show <BeakerRY>
			give <BeakerRY>
		}
		use <Blue Chemical> {
			msg <You tip some of the blue chemical into the beaker.>
			hide <BeakerR>
			show <BeakerRB>
			give <BeakerRB>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerB>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, one third full of blue liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> {
			msg <You tip some of the red chemical into the beaker.>
			hide <BeakerB>
			show <BeakerBR>
			give <BeakerBR>
		}
		use <Yellow Chemical> {
			msg <You tip some of the yellow chemical into the beaker.>
			hide <BeakerB>
			show <BeakerBY>
			give <BeakerBY>
		}
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerY>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, one third full of yellow liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> {
			msg <You tip some of the red chemical into the beaker.>
			hide <BeakerY>
			show <BeakerYR>
			give <BeakerYR>
		}
		use <Blue Chemical> {
			msg <You tip some of the blue chemical into the beaker.>
			hide <BeakerY>
			show <BeakerYB>
			give <BeakerYB>
		}
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerRB>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of red and blue liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Yellow Chemical> {
			msg <You tip some of the yellow chemical into the beaker.>
			hide <BeakerRB>
			show <BeakerRBY>
			give <BeakerRBY>
		}
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerRY>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of red and yellow liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Blue Chemical> {
			msg <You tip some of the blue chemical into the beaker.>
			hide <BeakerRY>
			show <BeakerRYB>
			give <BeakerRYB>
		}
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerBR>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of blue and red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Yellow Chemical> {
			msg <You tip some of the yellow chemical into the beaker.>
			hide <BeakerBR>
			show <BeakerBRY>
			give <BeakerBRY>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerBY>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of blue and yellow liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> {
			msg <You tip some of the red chemical into the beaker.>
			hide <BeakerBY>
			show <BeakerBYR>
			give <BeakerBYR>
		}
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerYR>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of yellow and red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Blue Chemical> {
			msg <You tip some of the blue chemical into the beaker.>
			hide <BeakerYR>
			show <BeakerYRB>
			give <BeakerYRB>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerYB>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, two thirds full of yellow and blue liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> {
			msg <You tip some of the red chemical into the beaker.>
			hide <BeakerYB>
			show <BeakerYBR>
			give <BeakerYBR>
		}
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerRBY>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, blue and yellow liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerRYB>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, yellow and blue liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerBRY>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, red and yellow liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerBYR>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, yellow and red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerYRB>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, red and blue liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerYBR>
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, blue and red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <There's nothing special about it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop nowhere <This flask is useful for mixing potions. Don't lose it!>
	end define

	define object <BeakerRBY1>
		#!qdk-note:  This is Acid
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, blue and yellow liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This liquid hisses and spits slightly. It also gives off an acrid burning smell that makes your eyes water. It appears to be a deadly acid.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <Drinking that would leave you with a large burning hole where your digestive system used to be.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerRYB1>
		#!qdk-note:  This is Enhanced Strength Potion
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, yellow and blue liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion seems to throb with energy. It looks and smells thoroughly invigorating.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use {
			msg <You drink the chemical solution and immediately feel it's invigorating effects. Your muscles feel charged with electricity and you find yourself becoming immensely strong.>
			hide <BeakerRYB1>
			show <Beaker>
			give <Beaker>
			flag on <playerstrong>
			timeron <strengthpotiontimelast>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerBRY1>
		#!qdk-note:  This serum freezes things
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, red and yellow liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <You can feel the chill from this potion without touching it, and frost is developing on the flask.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <Probably not a good idea to drink that unless you've got a really bad fever.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerBYR1>
		#!qdk-note:  This is poison.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, yellow and red liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This greeny-brown liquid is thin and runny, with streaks of silver in it. It is odourless, but you can just tell it's poisonous...>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <You're not about to drink anything so obviously poisonous!>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerYRB1>
		#!qdk-note:  This smells bad but does nothing.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, red and blue liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion stinks really badly. It's sulphurous and nasty.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use {
			msg <You hold your nose and down the foul-smelling liquid. After a few seconds, you feel... nothing. This potion seems to be completely useless.>
			hide <BeakerYRB1>
			show <Beaker>
			give <Beaker>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerYBR1>
		#!qdk-note:  Gives you muscle spasms.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, blue and red liquid. It's been processed by the Hydroscope machine.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion is spitting constantly and bubbling a lot. It smells of lavender.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use {
			msg <You drink down the fizzing, bubbling liquid. For a moment you feel nothing, then you collapse on the floor, shaking uncontrollably. You'll have to wait for the potion to wear off before you can do anything.>
			pause <20000>
			msg <The effects of the shaking potion have worn off.>
			hide <BeakerYBR1>
			show <Beaker>
			give <Beaker>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerRBY2>
		#!qdk-note:  This is love potion.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, blue and yellow liquid. It's plasma enhanced.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This pinkish red potion smells really good. In fact, it's kind of turning you on...>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <You're not certain how strong the aphrodisiac effects of this potion will be - you'd better not test it on yourself!>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerRYB2>
		#!qdk-note:  This makes you so weak you drop everything.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of red, yellow and blue liquid. It's plasma enhanced.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This liquid is pulsing slightly. Every now and then a thick bubble develops and bursts like a boil. It doesn't look particularly tasty.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use {
			msg <You drink the potion you have concocted. You immediately feel like energy is draining from your body. Your muscles sag and you lose all your strength. You can do nothing until the potion wears off.>
			pause <20000>
			msg <The effects of the weakness potion have worn off.>
			hide <BeakerRYB2>
			show <Beaker>
			give <Beaker>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerBRY2>
		#!qdk-note:  This is antifreeze.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, red and yellow liquid. It's plasma enhanced.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion is hot - the flask is uncomfortable to hold for long periods of time. It's giving off a fine steam.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <You would drink it, but it might just burn your insides.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerBYR2>
		#!qdk-note:  This is sticky
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of blue, yellow and red liquid. It's plasma enhanced.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This yellowish black liquid gloops slowly around the flask. It seems very sticky, almost like glue.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <Touching the liquid sticks your fingers together - drinking it would be extremely fatal.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerYRB2>
		#!qdk-note:  This is basically nitroglycerine - explosive when chucked.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, red and blue liquid. It's plasma enhanced.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion appears to be highly unstable - it keeps spitting. You would hazard a guess that it would explode if thrown or shaken too much.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use msg <The concoction in the flask is bubbling noxiously. It doesn't look safe to drink.>
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

	define object <BeakerYBR2>
		#!qdk-note:  This steadies your muscles - making you a good aim.
		alias <Flask>
		alt <beaker; jar; cup; jug; glass>
		look <It's a flask, full of yellow, blue and red liquid.>
		take <You pick up the flask.>
		speak <It can't talk.>
		examine <This potion is very odd - the surface fails to ripple even when you move it about. It smells faintly of wheatgrass.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use {
			msg <You drink the strange liquid. It feels cold and smooth as you swallow it. After a moment, you feel your muscles start to tense. You suddenly find that all your movements are much more precise and you have total control over your body movements. If you hold out your hand there is no movement or shaking, it is totally steady.>
			flag on <steady>
			hide <BeakerYBR2>
			show <Beaker>
			give <Beaker>
		}
		use <Red Chemical> msg <The beaker already contains some of the red chemical.>
		use <Blue Chemical> msg <The beaker already contains some of the blue chemical.>
		use <Yellow Chemical> msg <The beaker already contains some of the yellow chemical.>
		use anything msg <Putting that in the flask won't help.>
		drop choose <drop potion>
	end define

end define

define room <Refridgerator>
	alias <Refrigerator>
	look <It's cold in here. Various frost-encrusted shelves line the room. The fridge appears almost empty.>
	indescription <You are in a large, walk-in: >
	west <Labnorth>

	define object <Red Chemical>
		alias <Red Chemical>
		alt <red>
		look <It's a swirling chemical mix in a vibrant scarlet colour.>
		take <You pick up the vial of liquid.>
		speak <It can't talk.>
		examine <It doesn't seem to have any chemical effects on it's own. Perhaps it needs mixing.>
		prefix <a vial of>
		article <it>
		gender <it>
		drop nowhere <This extremely useful chemical should not be left lying around. Keep hold of it.>
	end define

	define object <Yellow Chemical>
		alias <Yellow Chemical>
		alt <red>
		look <It's a swirling chemical mix in a light yellow colour.>
		take <You pick up the vial of liquid.>
		speak <It can't talk.>
		examine <It doesn't seem to have any chemical effects on it's own. Perhaps it needs mixing.>
		prefix <a vial of>
		article <it>
		gender <it>
		drop nowhere <This extremely useful chemical should not be left lying around. Keep hold of it.>
	end define

	define object <Blue Chemical>
		alias <Blue Chemical>
		alt <red>
		look <It's a swirling chemical mix in a deep blue colour.>
		take <You pick up the vial of liquid.>
		speak <It can't talk.>
		examine <It doesn't seem to have any chemical effects on it's own. Perhaps it needs mixing.>
		prefix <a vial of>
		article <it>
		gender <it>
		drop nowhere <This extremely useful chemical should not be left lying around. Keep hold of it.>
	end define

	define object <Dead Scientist>
		alias <Dead Scientist>
		alt <dead body; body; corpse; stiff; scientist; man>
		look <This man was wearing a white scientist's coat when he died. Frost is forming on his face in the cold atmosphere in here. Blood has trickled from his nose, mouth, ears and even his eyes. It seems he got quite a concentrated dose of the airborne poison.>
		take msg <Dragging a corpse around with you can only slow you down.>
		speak <His dead lips are frozen shut in a grimace of pain - you won't get much conversation out of him.>
		examine <He's not carrying anything in any of his pockets.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <Labsouth>
	alias <Laboratory>
	look <This room has several benches covered in bunsen burners, strange chemicals and other scientific equipment. It also features two large machines of unknown purpose.>
	indescription <You find yourself in a high-tech:>
	north <Reception>

	define object <Hydroscope>
		alias <Hydroscope>
		look <It's a large cylindrical machine with a blue light glowing inside it. There's a slot for inserting flasks of liquid.>
		take msg <It's built into the floor.>
		speak <It's a machine - it can't talk.>
		examine <It appears to perform some sort of molecular restructuring task, but you don't really understand the science of it.>
		prefix <the>
		article <it>
		gender <it>
		use <BeakerRBY> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerRBY>
			show <BeakerRBY1>
			give <BeakerRBY1>
		}
		use <BeakerRYB> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerRYB>
			show <BeakerRYB1>
			give <BeakerRYB1>
		}
		use <BeakerBRY> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerBRY>
			show <BeakerBRY1>
			give <BeakerBRY1>
		}
		use <BeakerBYR> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerBYR>
			show <BeakerBYR1>
			give <BeakerBYR1>
		}
		use <BeakerYRB> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerYRB>
			show <BeakerYRB1>
			give <BeakerYRB1>
		}
		use <BeakerYBR> {
			msg <You slot the flask of liquid into the hydroscope. The machine sucks it in, whirrs and shakes somewhat, and eventually spits out a new flask of liquid. You pick it up.>
			hide <BeakerYBR>
			show <BeakerYBR1>
			give <BeakerYBR1>
		}
	end define

	define object <Plasma Reactor>
		alias <Plasma Reactor>
		alt <reactor>
		look <It's a large device with a flat metal plate for placing objects, and a large ray-gun-like device pointing over it from the ceiling.>
		take msg <It's a huge machine and it's bolted to the floor - you can't budge it.>
		speak <It's a machine - it can't speak.>
		examine <It looks like it will infuse something with plasma once placed on the plate. You're not sure what effect this might have on something.>
		prefix <the>
		article <it>
		gender <it>
		use <BeakerRBY> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerRBY>
			show <BeakerRBY2>
			give <BeakerRBY2>
		}
		use <BeakerRYB> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerRYB>
			show <BeakerRYB2>
			give <BeakerRYB2>
		}
		use <BeakerBRY> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerBRY>
			show <BeakerBRY2>
			give <BeakerBRY2>
		}
		use <BeakerBYR> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerBYR>
			show <BeakerBYR2>
			give <BeakerBYR2>
		}
		use <BeakerYRB> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerYRB>
			show <BeakerYRB2>
			give <BeakerYRB2>
		}
		use <BeakerYBR> {
			msg <You place the flask of liquid onto the plasma reactor's plate and switch it on. The ray-gun arm leans over the liquid and emits a bright beam of purplish energy into it. The liquid bubbles slightly and takes on a purplish hue. Once the machine has finished, you pick it up.>
			hide <BeakerYBR>
			show <BeakerYBR2>
			give <BeakerYBR2>
		}
	end define

	define object <Disk>
		alias <Disk>
		alt <Backup disk; disc>
		look <It's a high volume backup disk. It's labelled Thursday.>
		take <You pick up the blank disk.>
		speak <It's an inanimate object and cannot talk.>
		examine <It doesn't seem to have any data on it yet.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Blackboard>
		alias <Blackboard>
		alt <board; wall; chalk board; chalkboard>
		look <It's a standard chalkboard. It's covered in notes and sums.>
		take msg <It's a bit big to take.>
		examine <You take a closer look at the blackboard. The notes all relate to chemical mixtures:|n|nThe machines act as catalysts for the reactions. It doesn't work with just two chemicals, you need all three. Adding them in different orders makes for different results:|n|nRed, Blue, then Yellow - Makes an acid in the Hydroscope and some strange pink potion in the Plasma reactor.|nRed, Yellow, then Blue - seems to affect the tensile strength of one's muscles.|nBlue, Red then Yellow - varies greatly in temperature depending on the machine used.|nBlue, Yellow then Red - makes some sort of glue in the Plasma reactor.|nYellow, Red then Blue - Hydroscope - smells really bad! Plasma reactor could cause this to become unstable.|nYellow, Blue, then Red - seems to affect the speed of nerve endings firing. Could affect muscle spasms.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Booth>
		alias <Booth>
		alt <Teleporter; Teleport Booth>
		look <It's a large booth built into the wall. Inside are a variety of controls and dials. It appears to be used for teleporting.>
		take {
			msg <You step into the booth and press the Transport button. With a shuddering noise, you are catapulted across space and time to arrive right on top of the GPT.>
			goto <$locationof(GPT)$>
		}
		speak <It is humming and beeping occasionally, but doesn't speak.>
		examine <Reading the clear instructions reveals that the machine allows someone with a Global Positioning Transporter (GPT) to instantly travel back to this booth. One can also use this booth to teleport to the current location of the GPT. To do so, simply attempt to TAKE the booth.>
		prefix <a>
		article <it>
		gender <it>
		use <GPT> msg <You can't use the GPT on the booth directly. To teleport, simply use the GPT anywhere to be taken back to the laboratory in an instant. When you attempt to TAKE the booth, you will be instantly teleported back to the location of the GPT.>
	end define

	define object <GPT>
		alias <GPT>
		alt <Global Positioning Transporter; Transporter; Translocator>
		look <It's a small metal disc with a number of dials and some kind of projector.>
		take <You pick up the transporter.>
		speak <It says nothing at all.>
		examine <It's a Global Positioning Transporter, used to teleport between locations. It is used in conjunction with the booth in the laboratory.>
		prefix <a>
		article <it>
		gender <it>
		use {
			lose <GPT>
			msg <You place the GPT on the floor and use it to teleport back to the laboratory. With a swish noise, you are whisked away and find yourself instantly reappearing inside the teleport booth in the laboratory. You step out, slightly disoriented.>
			goto <Labsouth>
		}
		drop everywhere <You place the GPT. Now you can teleport back to this location from the booth in the laboratory.>
	end define

end define

define room <Area C Control Room>
	alias <Area C Control Room>
	look <This room has metal panels all over the walls, and a huge computer system built around three quarters of the room.>
	indescription <A large sign on the wall proclaims this to be:>
	east <Workshop>

	define object <Ventilation Computer>
		alias <Ventilation Computer>
		alt <computer; vent computer>
		look <This computer controls all the ventillation for Area C apparently. It's fully operational, which is why the deadly poison gas was neutralised so quickly.>
		take msg <The computer system is built into three walls of the room. It's impossible to take!>
		speak <It doesn't talk.>
		examine <The air monitoring software is ready to be backed up. But it's missing a tape.>
		prefix <the>
		article <it>
		gender <it>
		use <Disk> {
			msg <You insert the backup disk and hit OK on the backup software. The disk whirrs as the disk drive starts to write information to it. Eventually a message appears onscreen to say the backup completed successfully. The disk ejects and you pick it up.>
			hide <Disk>
			hide <Ventilation Computer>
			show <Ventilation Computer2>
			show <Disk2>
			give <Disk2>
		}
	end define

	define object <Ventilation Computer2>
		alias <Ventilation Computer>
		alt <computer; vent computer>
		look <This computer controls all the ventillation for Area C apparently. It's fully operational, which is why the deadly poison gas was neutralised so quickly.>
		take msg <The computer system is built into three walls of the room. It's impossible to take!>
		speak <It doesn't talk.>
		examine <The air monitoring software has been backed up. There's nothing more you can do here.>
		prefix <the>
		article <it>
		gender <it>
		hidden
		use <Disk> {
			msg <You insert the backup disk and hit OK on the backup software. The disk whirrs as the disk drive starts to write information to it. Eventually a message appears onscreen to say the backup completed successfully. The disk ejects and you pick it up.>
			hide <Disk>
			hide <Ventilation Computer>
		}
	end define

	define object <Disk2>
		alias <Disk>
		alt <Backup disk; disc>
		look <It's a high volume backup disk. It's labelled Thursday.>
		take <You pick up the disk.>
		speak <It's an inanimate object and cannot talk.>
		examine <The disk contains a backup of the Ventilation system software.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Hall>
	alias <Hallway>
	look <A sign proclaims that the laboratory and detention area is Area C. This room seems to be a nexus between Area C and another area of the base.>
	indescription <You are in a short:>
	south msg <The door labelled Area B will not open. Red warning lights are shining above the door and a small LED display states "Area B compromised. Immediate Ventillation required.">
	east <Area B Control Room>
	west <Reception>
end define

define room <Area B Control Room>
	alias <Area B Control Room>
	look <This room is fairly small and houses the computer system that controls ventilation for Area B.>
	indescription <This room is the: >
	west <Hall>

	define object <VentCompAreaB>
		alias <Ventilation Computer>
		alt <Vent computer; computer>
		look <This computer controls the air monitoring and ventilation for Area B.>
		take msg <It's built into the wall.>
		speak <It beeps occasionally but doesn't talk.>
		examine <The system is corrupted and needs restoring from a backup. Area B is still filled with toxic gas.>
		prefix <a>
		article <it>
		gender <it>
		use <Disk2> {
			msg <You insert the backup disk and restore the Ventilation system software. Once it is operational, a warning flashes up and the ventilation systems activate. Presently a message flashes up saying that air levels in Area B are safe.>
			hide <VentCompAreaB>
			show <VentCompAreaB2>
			hide <Disk2>
			create exit south <Hall; Warehouse>
		}
	end define

	define object <VentCompAreaB2>
		alias <Ventilation Computer>
		alt <Vent computer; computer>
		look <This computer controls the air monitoring and ventilation for Area B.>
		take msg <It's built into the wall.>
		speak <It beeps occasionally but doesn't talk.>
		examine <The system is fully operational. Area B has been vented of all toxic substances.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Warehouse>
	alias <Warehouse>
	look <This room is so large that the walls and ceiling are simply hewn from the rock. It is stacked high with assorted boxes and large crates. A few fluorescents have been driven into the ceiling to dimly illuminate the cave.>
	indescription <You are in a cavernous: >
	north <Hall>
	east <Office>

	define object <Freight Elevator Bottom>
		alias <Freight Elevator>
		alt <lift; elevator; freight lift>
		look choose <take lift up>
		take msg <You can't put that in your pocket!>
		speak <It's a lift, it can't talk.>
		examine choose <take lift up>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Deactivated Freight Elevator>
		alias <Freight Elevator>
		alt <lift; elevator; freight lift>
		look <It's a rickety metal freight elevator, at the bottom of a shaft which leads up out of the roof of the cavern.>
		take msg <You can't put that in your pocket!>
		speak <It's a lift, it can't talk.>
		examine <It's deactivated and can only be reactivated by a security card with clearance for Area A.>
		prefix <a>
		article <it>
		gender <it>
		use <writtencard> {
			msg <You swipe the lift controls with the security card. The machine processes the data then blips. The light on the lift controls turns green and it activates.>
			hide <Deactivated Freight Elevator>
			show <Freight Elevator Bottom>
		}
		use <Blank Card> msg <That security card is blank and will not work. If you could write a security clearance to it, it would become very useful.>
		use <Test Card> msg <The test card is rejected - it doesn't have the neccessary security clearances.>
	end define

end define

define room <Office>
	alias <Office>
	look <This office is a small hut built inside the main warehouse cave. It contains a desk and noticeboard and a filing cabinet. All three are covered in a liberal coating of shipping manifests and other paperwork.>
	indescription <You have entered an: >
	west <Warehouse>

	define object <Filing Cabinet>
		alias <Filing Cabinet>
		alt <cabinet>
		look <It's dull grey metal and has two draws.>
		take msg <The cabinet is a bit heavy to lug around, and none of the manifests will be of use to you.>
		speak <The filing cabinet says nothing.>
		examine <Each file seems to relate to a different company. It seems this corporation has been receiving shipments from arms dealers, chemical companies, vehicle manufacturers, personnel hire agencies and many more. There are also several files marked classified that note unspecified deliveries from a morgue.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Body>
		alias <Body>
		alt <corpse; stiff; man; dead body>
		look <This man appears to have died filling out a form for an order of medical supplies. A small trickle of blood from his nose has dried on his face.>
		take msg <You can't go lugging dead bodies around everywhere.>
		speak <There's really not much he can say - he is dead after all.>
		examine <You gingerly search his pockets but find nothing.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Security Map2>
		alias <Security Map 002>
		alt <map 001; map 1>
		look picture <map2.jpg>
		take <You pick up the tattered map.>
		speak <It doesn't talk.>
		examine <If you want to view the map, just look at it.>
		prefix <a copy of>
		article <it>
		gender <it>
		use picture <map2.jpg>
		use anything msg <You can't use that on the map.>
		use on anything msg <How is that going to achieve anything?>
	end define

end define

define room <Delivery Bay>
	alias <Delivery Bay>
	look <This barn-like building seems to house deliveries before they are taken down the freight elevator to be stored in the warehouse. A row of windows runs around the room at ceiling height, way above your head.>
	indescription <This is a: >
	south msg <The main shutter doors are closed and the power to them seems to be off. There's no way of opening them from here.>
	east <upstairs north east hallway>
	west <upstairs north west hallway>

	define object <Freight Elevator Top>
		alias <Freight Elevator>
		alt <lift; elevator; freight lift>
		look choose <take lift down>
		take msg <You can't put that in your pocket!>
		speak <It's a lift, it can't talk.>
		examine choose <take lift down>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Container>
		alias <Container>
		alt <crate>
		look <It's a long metal container. It's roughly painted red and the corporation's logo is emblazoned across the side.>
		take msg <It's a massive steel container; there's no way you can lift it.>
		examine <With some effort, you open the container. It is filled with boxes of pre-processed burger buns.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <upstairs north west hallway>
	alias <Hallway>
	look <This short corridor runs east to west. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript east-west:>
	east <Delivery Bay>
	west <Generator Room>
end define

define room <upstairs north east hallway>
	alias <Hallway>
	look <This short corridor runs east to west. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript east-west:>
	east msg <This door is firmly locked. The computer system requires a ten-digit pass number and a security card, neither of which you have. If only there was someway of resetting the system.>
	west <Delivery Bay>
end define

define room <Generator Room>
	alias <Generator Room>
	look <This bare stone room houses a sizeable power generator. Presumably this is what's giving electricity to the place.>
	indescription <You are in a stone: >
	south msg <The door is locked by a security console. Since you don't have any security clearance, there's no way of getting through without resetting the system.>
	east <upstairs north west hallway>

	define object <Sentry Robot>
		alias <Sentry Robot>
		alt <robot; bot>
		look <It's a robot with a large gun protruding from it's back. It seems to be guarding the generator. It's making a circular patrol movement around the room.>
		take msg <Trying to pick that up might just result in a bullet to the head.>
		speak <It doesn't talk back.>
		examine <It's wheels seem farely small and flimsy. The gun however does not.>
		prefix <a>
		article <it>
		gender <it>
		use <BeakerBYR2> {
			msg <You tip the sticky solution onto the floor in the furthest corner of the robot's patrol route. Presently the robot circles round and gets stuck fast. It's now glued to the floor facing the corner!>
			hide <Sentry Robot>
			hide <Generator>
			show <Sentry Robot2>
			show <Generator2>
			hide <BeakerBYR2>
			show <Beaker>
			give <Beaker>
		}
	end define

	define object <Sentry Robot2>
		alias <Sentry Robot>
		alt <robot; bot>
		look <It's a robot with a large gun protruding from it's back. It's stuck facing the corner.>
		take msg <It's firmly glued to the floor.>
		speak <It doesn't talk back.>
		examine <The sticky substance has glued it's wheels to the floor and it can't turn to face you.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Generator>
		alias <Generator>
		look <It's a large, functional generator.>
		take msg <Even if the security robot let you get close, there's no way you could pick up a generator.>
		speak <It hums a bit but doesn't talk.>
		examine <You can't get close to it - the security robot warns you to back off or it will shoot. You'll have to get rid of the robot first.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Generator2>
		alias <Generator>
		look <It's a large, functional generator.>
		take msg <There's no way you could pick up a generator.>
		speak <It hums a bit but doesn't talk.>
		examine choose <power cycles>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Generator3>
		alias <Generator>
		look <It's a large, functional generator.>
		take msg <There's no way you could pick up a generator.>
		speak <It hums a bit but doesn't talk.>
		examine <You have reset the power and restored everything to it's default settings in Area A.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <Barracks>
	alias <Barracks>
	look <This long room is full of bunks and appears to be the guards' sleeping quarters.>
	indescription <This room appears to be the guards':>
	south <Break Room>
	west <upstairs north east hallway>

	define object <CompMagazine>
		alias <Magazine>
		look <It's the latest copy of PCGamer. It's got an article about Half-Life 2 and a review of Quake 4. A quite unexplainable feeling of inadequacy passes over you...>
		take msg <There's no point taking that with you.>
		examine <You don't have time to be reading magazines.>
		prefix <a>
		detail <Computer Magazine>
		article <it>
		gender <it>
	end define

end define

define room <Break Room>
	alias <Break Room>
	look <This lounge area seems to be where the guards can get some R & R. There is a television, several sofas and a pool table.>
	indescription <You are in a plush:>
	north <Barracks>
	south <Weapons Room>

	define object <TV>
		alias <TV>
		alt <television>
		look <It's not tuned in. Nothing but white noise plays.>
		take msg <It's a bit bulky to be carrying around.>
		examine <It's quite small, probably only 14 inches across. There's a video player underneath.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Videos>
		alias <Videos>
		alt <video; tapes; tape>
		look <These videos must be the best entertainment these guards can get.>
		take msg <None of these titles seems even remotely interesting.>
		examine <There's quite a lot here - several of the films are in Blockbuster cases. You browse the titles: Zombiefest, Psycho Chainsaw Armageddon 3, The Blood Howl, Vampyr, The Terrible Werewolf of Doom... One of these guards must be a fan of bad horror films.>
		prefix <a shelf full of>
		article <them>
		gender <it>
	end define

	define object <Book>
		alias <Book>
		look <It's called The Ghost in the Mirror. It appears to be a child's puzzle book.>
		take <You pick up the puzzle book.>
		examine <It's full of fairly easy puzzles and a quite dire storyline. One of the characters is called Professor X. Periment.>
		prefix <a>
		article <it>
		gender <it>
		drop everywhere <You drop the puzzle book.>
	end define

end define

define room <Weapons Room>
	alias <Weapons Room>
	look <This room serves as a waiting room for the target range and a place to collect arms. A reinforced window sits above a high counter to provide secure access to the guns.>
	indescription <You in the public half of a:>
	north <Break Room>
	south <Target Range>
	east msg <You can't access the weapon storage room. The door is sealed with a card reader.>

	define object <SecurityDoorWeaponsRoom>
		alias <Security Door>
		alt <door; scanner; card scanner>
		look <It's a heavy security door leading to the weapons storage area. It's sealed by a security card reader.>
		take if flag <playerstrong> then {
			msg <You yank the door open, snapping the solid iron bolt in two. The door swings forlornly open, your super-strong hand-print embedded in the twisted metal.>
			create exit east <Weapons Room; Weapons Storage Room>
			hide <SecurityDoorWeaponsRoom>
		}
		else msg <You can't budge it with your bare hands.>
		examine <It doesn't quite fit the door frame and there's about a centimetre gap where you can see the thick metal bolt holding the door to the frame.>
		prefix <a>
		article <it>
		gender <it>
		use <BeakerYRB2> msg <You really shouldn't be throwing explosives at a room full of weaponry.>
		use <BeakerRBY1> {
			msg <You carefully tip the acidic liquid onto the bolt through the gap. The metal steams and hisses and starts to bubble. Soon the bolt is melted through. The door swings open.>
			create exit east <Weapons Room; Weapons Storage Room>
			hide <SecurityDoorWeaponsRoom>
			hide <BeakerRBY1>
			show <Beaker>
			give <Beaker>
		}
		use anything msg <You can't open the door with that.>
	end define

end define

define room <Target Range>
	alias <Target Range>
	look <This room houses a series of long ranges, each one with a target of a different distance. Spent bullet casings litter the floor.>
	indescription <You are standing at one end of a long:>
	north <Weapons Room>
	east msg <The targets lie in this direction. They are suspended over a large pit for some reason and there's no way you can go this way without breaking your legs.>
	west <upstairs south east hallway>

	define object <Target>
		alias <Target>
		look <It's quite far down the range to the east but it appears to be different to the other targets. It has no bullet holes in it...>
		take msg <It's far too far away to interact with.>
		speak <It can't talk back.>
		examine <It looks like the bullseye is a metal button, although it's too far away to be sure.>
		prefix <a>
		article <it>
		gender <it>
		use <Machine Gun> if flag <steady> then {
			msg <You take careful aim and pull the trigger. The chemical coursing through your blood has turned your muscles to stone and the bullet follows an exact path to the centre of the bullseye. The metal button clicks loudly and the whole room starts to shake. The floor of the pit thirty feet below slowly flips over and then moves up a set of rails to be in line with the floor. The targets on the range flip up and disappear into the ceiling.>
			hide <Target>
			hide <Target2>
			dec <Machine Gun Ammunition; 1>
			create exit east <Target Range; Operations Room>
		}
		else {
			msg <You take aim and carefully pull the trigger. But you're no great shot and you can't even hit the target at that long range, let alone the bullseye. Your shots are wasted.>
			hide <Target>
			show <Target2>
			dec <Machine Gun Ammunition; 5>
		}
	end define

	define object <Target2>
		alias <Target>
		look <It's quite far down the range to the east but it appears to be different to the other targets. It has no bullet holes in it...>
		take msg <It's far too far away to interact with.>
		speak <It can't talk back.>
		examine <It looks like the bullseye is a metal button, although it's too far away to be sure.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Machine Gun> if flag <steady> then {
			msg <You take careful aim and pull the trigger. The chemical coursing through your blood has turned your muscles to stone and the bullet follows an exact path to the centre of the bullseye. The metal button clicks loudly and the whole room starts to shake. The floor of the pit thirty feet below slowly flips over and then moves up a set of rails to be in line with the floor. The targets on the range flip up and disappear into the ceiling.>
			hide <Target>
			hide <Target2>
			dec <Machine Gun Ammunition; 1>
			create exit east <Target Range; Operations Room>
		}
		else {
			msg <There's no point wasting even more bullets. If you're going to hit that target, you'll need to improve your aim before you waste any more ammunition.>
		}
	end define

end define

define room <upstairs south east hallway>
	alias <Hallway>
	look <This short corridor runs east to west. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript east-west:>
	east <Target Range>
	west <entrance hall>
end define

define room <upstairs south west hallway>
	alias <Hallway>
	look <This short corridor runs east to west. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript east-west:>
	east <entrance hall>
	west <medical facility>
end define

define room <entrance hall>
	alias <Entrance Hall>
	north <Courtyard>
	east <upstairs south east hallway>
	west <upstairs south west hallway>
	description if exists <Container2> then msg <This is the entrance hall. A large metal container has destroyed most of one wall and half the ceiling. A cold wind is now blowing a few papers about the place.> else msg <This is the entrance hall. It's spacious and clean. The outer door to the south is locked but there seems to be a way into the courtyard to the north.>

	define object <Container2>
		alias <Container>
		alt <crate>
		look <It's a long metal container. It's roughly painted red and the corporation's logo is emblazoned across the side. It's slightly dented and leaning against the wall through a large hole in the roof.>
		take msg <It's a massive steel container; there's no way you can lift it.>
		examine choose <climbroof>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <medical facility>
	alias <Medical Facility>
	look <This room is clearly used for treating injuries. Several simple cots line the walls, each one with an attached monitor and medical equipment. An antiseptic smell pervades the air.>
	indescription <You are in a high-tech:>
	north <southeast north-south hallway>
	east <upstairs south west hallway>

	define object <Security Locker>
		alias <Security Locker>
		look <It's a metal security locker built into an alcove of the wall. It's locked. The lock has buttons for each number as well as a button for each of the four suits in a deck of cards. An LED display is asking you for a number for each suit.>
		take msg <It's quite firmly attached to the floor.>
		examine choose <Hearts>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Electrolysis Machine>
		alias <Electrolysis Machine>
		alt <machine>
		look <This strange device seems to be used to infuse the subject with electricity. Somehow this must help with curing certain diseases. It looks dangerous to you though.>
		take msg <It's a massive piece of medical equipment; you can't pick it up.>
		examine <There's a drawer where the subject lies before being taken into the machine for electrolysing.>
		prefix <an>
		article <it>
		gender <it>
		use <DeadBattery> {
			msg <You put the flat battery on the drawer and switch the machine on. The drawer slides into the machine and blue bolts of electricity start shooting through the machine. Presently, the machine finishes it's cycle and ejects the battery, fully charged.>
			hide <DeadBattery>
			show <LiveBattery>
			give <LiveBattery>
		}
	end define

	define object <LiveBattery>
		alias <Battery>
		alt <live battery>
		look <It's a heavy duty industrial battery, used to power a large machine.>
		take <You pick up the fully charged battery.>
		examine <It's fully charged at the moment and just needs plugging in.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Key>
		alias <Key>
		alt <bike key; motorbike key; motorcycle key>
		look <This appears to be the key to a vehicle like a car or motorbike.>
		take <You pocket the key.>
		examine <A keyring hangs loosely from it. There's nothing special about it.>
		prefix <a>
		detail <Vehicle Key>
		article <it>
		gender <it>
		hidden
		drop nowhere <You'd better not leave this lying around just anywhere!>
	end define

	define object <Security Locker2>
		alias <Security Locker>
		look <It's a metal security locker built into an alcove of the wall. It's open. There is a small key inside.>
		take msg <It's quite firmly attached to the floor.>
		examine choose <motorbikekey>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Security Locker3>
		alias <Security Locker>
		look <It's a metal security locker built into an alcove of the wall. It's open.>
		take msg <It's quite firmly attached to the floor.>
		examine <There's nothing else in it - it's completely empty.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <southeast north-south hallway>
	alias <Hallway>
	look <This short corridor runs north to south. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript north-south:>
	north <Waiting Room>
	south <medical facility>
end define

define room <Waiting Room>
	alias <Waiting Room>
	look <This part of the corrridor curves outwards into a semi-circular waiting area, presumably for the office to the east.>
	indescription <You make your way into a:>
	north <northeast north-south hallway2>
	south <southeast north-south hallway>
	east <Plushoffice>

	define object <Magazine>
		alias <Newsletter>
		alt <Letter>
		look <It's a copy of IF Monthly.>
		take <You pick up the magazine.>
		examine {
			msg <You flick through the pages. It's all about text adventures. You wonder who the hell plays those any more. About halfway through, a small scrap of paper falls out of flickers to the floor.>
			show <Scrap of paper>
			hide <Magazine>
			show <Magazine2>
			give <Magazine2>
		}
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Scrap of paper>
		alias <Scrap of paper>
		alt <scrap; paper; code; number>
		look <It's a torn scrap of plain paper. There's nothing written on it.>
		take <You grab the scrap of paper.>
		examine <It smells faintly of some kind of chemical that you can't place.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <BeakerYRB1> {
			msg <You tip the foul-smelling chemical onto the piece of paper. There is a reaction - suddenly ink starts fading out of the paper. An invisible message appears before your eyes. It's a four digit code: 7218.>
			hide <Scrap of paper>
			show <Scrap of paper2>
			give <Scrap of paper2>
			hide <BeakerYRB1>
			show <Beaker>
			give <Beaker>
		}
	end define

	define object <Magazine2>
		alias <Newsletter>
		alt <Letter>
		look <It's a copy of IF Monthly.>
		take <You pick up the magazine.>
		examine <This month a game called The Mansion is reviewed. It's got five out of five stars.>
		hidden
	end define

	define object <Scrap of paper2>
		alias <Scrap of paper>
		alt <scrap; paper; code; number>
		look <It's a torn scrap of plain paper. The chemical has reacted with some invisible ink in the paper and revealed a four digit code: 7218>
		take <You grab the scrap of paper.>
		examine <It smells strongly of nasty, eggy chemical.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <northeast north-south hallway2>
	alias <Hallway>
	look <This short corridor runs north to south. There's nothing interesting about it except for some small windows which are so covered in dirt that they barely let the sunlight in, let alone let you look out.>
	indescription <You are in a non-descript north-south:>
	north <Generator Room>
	south <Waiting Room>
end define

define room <Plushoffice>
	alias <Office>
	look <This office obviously belongs to someone in a position of power. High quality antiques make up the furniture. A large bay window looks out on a courtyard to the east.>
	indescription <You have entered a large, plush:>
	west <Waiting Room>

	define object <Safe>
		alias <Safe>
		look <It's a small portable safe with a combination lock.>
		take msg <It's been securely welded to the floor.>
		speak <It can't speak.>
		examine choose <safedigit1>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Safe2>
		alias <Safe>
		look <It's a small portable safe with a combination lock. It's open.>
		take msg <It's been securely welded to the floor.>
		speak <It can't speak.>
		examine choose <safecontents>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <DVD-ROM>
		alias <DVD-ROM>
		alt <DVD; disc; cd>
		look <It's a DVD-ROM. It has not been written to. If you had access to a DVD writer, you could burn information onto it.>
		take <You pick up the blank disc.>
		examine <There's nothing special about it at the moment - there's no data on it.>
		prefix <a>
		suffix <disc>
		article <it>
		gender <it>
		hidden
		drop everywhere <You carefully put the disc down.>
	end define

end define

define room <Courtyard>
	alias <Courtyard>
	look <You are in a wide irregular-shaped courtyard in the middle of the surrounding building. It is cold out here. It's not snowing but there is ice on the ground and the sky is a gloomy light grey.>
	north {
		if flag <shutters> then goto <Delivery Bay> else {
			msg <You open the Delivery Bay shutter doors to the North.>
			create exit south <Delivery Bay; Courtyard>
			goto <Delivery Bay>
			flag on <shutters>
		}
	}
	south <entrance hall>

	define object <Crane Arm>
		alias <Crane Arm>
		alt <crane; arm; computer; screen; console; controls>
		look <This large robotic crane has an adjustable claw at the end for lifting heavy containers. A small computer console at the bottom controls the arm's movements. The battery is dead.>
		take msg <You can't pick that up - it's massively heavy.>
		examine choose <takedeadbattery>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <DeadBattery>
		alias <Battery>
		alt <dead battery>
		look <It's a heavy duty industrial battery, used to power a large machine.>
		take <You pick up the flat battery.>
		examine <It's completely flat at the moment and will need charging.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Crane Arm2>
		alias <Crane Arm>
		alt <crane; arm; computer; screen; console; controls>
		look <This large robotic crane has an adjustable claw at the end for lifting heavy containers. A small computer console at the bottom controls the arm's movements. There is no battery in it at the moment.>
		take msg <You can't pick that up - it's massively heavy.>
		examine <There's nothing more you can do without a fully charged battery.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <LiveBattery> {
			msg <You slot the fully charged battery into the machine and switch on the power. The arm moves slightly with a whirring sound, and the console screen turns on.>
			hide <LiveBattery>
			hide <Crane Arm2>
			show <Crane Arm3>
		}
	end define

	define object <Crane Arm3>
		alias <Crane Arm>
		alt <crane; arm; computer; screen; console; controls>
		look <This large robotic crane has an adjustable claw at the end for lifting heavy containers. A small computer console at the bottom controls the arm's movements. The battery is fully charged.>
		take msg <You can't pick that up - it's massively heavy.>
		examine choose <Do you wish to pick up the metal container with the crane?>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Crane Arm4>
		alias <Crane Arm>
		alt <crane; arm; computer; screen; console; controls>
		look <This large robotic crane has an adjustable claw at the end for lifting heavy containers. A small computer console at the bottom controls the arm's movements. The battery is fully charged.>
		take msg <You can't pick that up - it's massively heavy.>
		examine msg <After the mess you've made, that's really not a good idea.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Crane Arm0>
		alias <Crane Arm>
		alt <crane; arm; computer; screen; console; controls>
		look <This large robotic crane has an adjustable claw at the end for lifting heavy containers. A small computer console at the bottom controls the arm's movements. The battery is dead.>
		take msg <You can't pick that up - it's massively heavy.>
		examine msg <You can't get near it because there's a vicious looking guard dog chained to it.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Dog>
		alias <Dog>
		alt <guard dog>
		look <This evil-looking rottweiler is chained to the crane arm's base, presumably to guard it. It growls at you when you move to go near, and bares it's teeth.>
		take msg <Picking the dog up would probably result in serious loss of limbs.>
		speak say <Woof!>
		examine <You can't get close enough to examine it.>
		prefix <a>
		article <it>
		gender <it>
		use <BeakerRBY2> {
			msg <You slop some of the strange pheremone potion near the dog. It's clearly thirsty and laps up the pink liquid. Suddenly it looks at you and whines, before panting in a friendly manner and bouncing up and down excitedly. It seems to be in love...>
			hide <Dog>
			show <Dog2>
			hide <Crane Arm0>
			show <Crane Arm>
			hide <BeakerRBY2>
			show <Beaker>
			give <Beaker>
		}
		use <Machine Gun> {
			msg <You take aim, and hope no animal lovers are around, before pumping a few rounds into the canine creature. It whines, then slumps back dead as your last bullet sprays the back of it's head everywhere.>
			hide <Dog>
			show <Dog3>
			hide <Crane Arm0>
			show <Crane Arm>
			dec <Machine Gun Ammunition; 8>
		}
	end define

	define object <Dog2>
		alias <Dog>
		alt <guard dog>
		look <This docile-looking rottweiler is chained to the crane arm's base, presumably to guard it. It whines and pants at you when you move to go near.>
		take msg <If you pick the dog up now, it'd probably lick you to death. Or just hump your leg.>
		speak say <Woof!>
		examine <There's nothing on it's collar and seems in fine health. It's also madly in love with you.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Dog3>
		alias <Dog>
		alt <guard dog>
		look <This dead rottweiler is chained to the crane arm's base, presumably to guard it. It's not doing a very good job at it though, as it's brains are smeared across the courtyard.>
		take msg <What are you going to do with a leaky dog corpse? On second thoughts, don't answer that...>
		speak msg <It's dead.>
		examine <It smells really bad, but there's nothing special about it, and nothing on it's collar.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <BeakerRBY2> {
			msg <You slop some of the strange pheremone potion near the dog. It's clearly thirsty and laps up the pink liquid. Suddenly it looks at you and whines, before panting in a friendly manner and bouncing up and down excitedly. It seems to be in love...>
			hide <Dog>
			show <Dog2>
			hide <Crane Arm0>
			show <Crane Arm>
		}
	end define

end define

define room <Operations Room>
	alias <Operations Room>
	look <This room houses many large computers. A keyboard and monitor at one end control the huge server database. This room came out of the floor of the target range.>
	indescription <You have climbed over the target range stalls into a large:>
	west <Target Range>

	define object <Console>
		alias <Console>
		alt <computer; monitor>
		look <This console allows access to all the data stored in this room. There are all sorts of incriminating files relating to the deadly toxin your uncle helped develop, and information about other experiments which you don't have time to study in depth.>
		take msg <It's connected to every computer in this room, not to mention the wall.>
		examine <The computer has a DVD burner drive, but there are no discs nearby that you can see.>
		prefix <a>
		article <it>
		gender <it>
		use <DVD-ROM> {
			msg <You put the blank DVD into the console's DVD burner drive and use the default burning software to write as much information to the disc as possible. You now have a DVD crammed full of incriminating evidence against the corporation.>
			hide <DVD-ROM>
			show <DVD-ROM2>
			give <DVD-ROM2>
		}
	end define

	define object <DVD-ROM2>
		alias <DVD-ROM>
		alt <DVD; disc; cd>
		look <It's a DVD-ROM. It has lots of incriminating evidence against the corporation written to it.>
		take <You pick up the blank disc.>
		examine <This is a very important piece of evidence. It's got files, reports, images and all sorts of data relating to the corporation's chemical experiments.>
		prefix <a>
		suffix <disc>
		article <it>
		gender <it>
		hidden
		drop nowhere <This disc is far too valuable to just leave lying around.>
	end define

end define

define room <Weapons Storage Room>
	alias <Weapons Room>
	look <This room is stacked high with machine guns. There is just one box of ammunition left though.>
	indescription <You are in the secured part of the:>
	west <Weapons Room>

	define object <Ammunition>
		alias <Ammunition>
		alt <bullets; box; ammo; box of bullets>
		look <It's a box of bullets. They look like they fit a machine gun.>
		take {
			msg <You take the machine gun ammunition.>
			hide <Ammunition>
			inc <Machine Gun Ammunition; 25>
		}
		examine <These things are deadly - they have a hollow point designed to crumple and do massive damage to unarmoured opponents.>
		prefix <some>
		article <it>
		gender <it>
	end define

end define

define room <Roof>
	alias <Roof>
	look <It's cold and windy up here. You can see around you for miles. For the first time, you can try and get your bearings. You are on a small island. A haze of fog almost covers the far side but you can just make out a lighthouse and what might be another building. This facility is built on the cliff-top and you can now hear the sea below.|n|nYou can go east along the roof. The gaping hole in the roof blocks your route west.>
	indescription <You have clambered onto the:>
	east <Roof2>
	down <entrance hall>
	place <the; entrance hall> {
		msg <You clamber down the crashed metal container into the entrance hall.>
		goto <entrance hall>
	}
end define

define room <Roof2>
	alias <Roof>
	look <This section of the roof seems unstable now the container has smashed half a wall down. It wouldn't be a good idea to follow the roof any further.|n|nYou can go west back along the roof. A ladder leads down to the ground outside.>
	indescription <You have clambered onto the:>
	west <Roof>
	down <OutsideLab>

	define object <Ladder>
		alias <Ladder>
		look choose <downladder>
		examine <It's a safety ladder attached to the side of the building. The handrails have rusted slightly in the sea air. The rungs seem perfectly solid - you can climb down.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <Kitchen>
	alias <Kitchen>
	look <This kitchen was recently used to cook sub-standard burgers. A dead chef lies slumped in the corner.>
	indescription <You are in a hot, smoky:>
	south <Cafeteria>

	define object <Chef>
		alias <Chef>
		alt <corpse; stiff; body; dead chef>
		look <It's the body of a white-aproned chef. He appears to have died on the job as there is barbeque sauce all down his front.>
		take msg <Lugging corpses around won't help you much.>
		speak <He's not very talkative.>
		examine <There's nothing on his person. He's very much dead.>
		prefix <the>
		article <it>
		gender <he>
	end define

	define object <Fire>
		alias <Fire>
		alt <flames; hob>
		look <The chef obviously left the hob on when he died and it has ignited quite a lot of the worktop where a bottle of oil has spilled. It seems to be contained but it is very hot. The sprinkler system in here has failed. Typical - the computer system can neutralise deadly poison gas but can't take care of a small fire! You can see a metal briefcase on the worktop but you can't get to it due to the flames.>
		take msg <You'll burn yourself if you try that!>
		examine <You can see a metal briefcase sitting in the midst of the flames. There's no way to take it at the moment though - it's far too hot.>
		prefix <a>
		article <it>
		gender <it>
		use <BeakerBRY1> {
			msg <You throw the super-cool liquid onto the fire. With a hiss, the liquid covers the oil and very quickly douses the flames. The room cools slightly and you can get to the hob to turn it off. It's also splashed all over the briefcase and put out the fire there.>
			hide <Fire>
			show <Briefcase>
			hide <BeakerBRY1>
			show <Beaker>
			give <Beaker>
		}
	end define

	define object <Briefcase>
		alias <Briefcase>
		alt <metal briefcase; case>
		look <It's a solid metal briefcase. It's locked with a combination lock.>
		take <You pick up the metal briefcase.>
		examine <You can't figure out the lock on your own. There doesn't seem to be any way to open it.>
		prefix <a metal>
		article <it>
		gender <it>
		hidden
		use <Knife> {
			msg <You slide the blade of the blunt knife into the crack of the briefcase and lever the briefcase open. It takes quite a lot of effort to prise the case open, but eventually the lock snaps and the case springs apart. Some kind of device falls out and you pick it up. It is a magnetic encoder.>
			hide <Briefcase>
			show <Briefcase2>
			show <Magnetic Encoder>
			give <Briefcase2>
			give <Magnetic Encoder>
		}
	end define

	define object <Magnetic Encoder>
		alias <Magnetic Encoder>
		alt <Encoder; Coder; Magnet>
		look <This device appears to be able to be used to write magnetic information to security cards.>
		take <You pick up the encoder.>
		examine <It's functional and ready to use.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Briefcase2>
		alias <Briefcase>
		alt <metal briefcase; case>
		look <It's a solid metal briefcase. It's snapped open and is empty.>
		take <You pick up the metal briefcase.>
		examine <There's nothing in it except a foam lining used to protect fragile contents.>
		prefix <a metal>
		article <it>
		gender <it>
		hidden
		use anything msg <Putting that in the briefcase won't help.>
	end define

end define

define room <OutsideLab>
	alias <Paved Area>
	look <The front of the Corporation building looms over you here, although the front door is firmly locked. Neat paving slabs make up a large square in the front of the building. Faded white paint vaguely outlines car parking spaces. It's very cold and the ground is icy in patches.|n|nA ladder leads to the roof.>
	indescription <You on outside the Corporation's facility, on a wide:>
	northeast msg <The rest of the island is laid out before you. But it's too far to walk to anywhere - you'll need transport.>
	up <Roof2>

	define object <Ladder2>
		alias <Ladder>
		look choose <upladder>
		examine <It's a safety ladder attached to the side of the building. The handrails have rusted slightly in the sea air. The rungs seem perfectly solid - you can climb up.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Motorbike>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <It's cold out here and the ignition is frozen up. There's no way to get a key in.>
		prefix <a>
		article <it>
		gender <it>
		use <Key> msg <You try to put the key in the ignition, but it won't go. You'll somehow need to unfreeze it.>
		use <BeakerBRY2> {
			msg <You pour some of the hot liquid over the motorbike lock and it instantly desfrosts with a hiss of steam.>
			hide <Motorbike>
			show <Motorbike2>
			hide <BeakerBRY2>
			show <Beaker>
			give <Beaker>
		}
	end define

	define object <Motorbike2>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <If you had a key, you could start it, but you're no expert at hot-wiring.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Key> {
			msg <You insert the key into the ignition and start the engine.>
			goto <Bike>
		}
	end define

end define

define room <Bike>
	alias <Motorbike>
	look <You can drive all over the island using the motorbike.|n|nThe corporation building is to the SOUTHWEST of the island.|nThe SOUTHEAST of the island sports a wide, sandy beach.|nThere is an abandoned house at the EAST edge of the island.|nThe highest point of the island is to the NORTH, where you can see a lighthouse.|nA dockhouse stands near a wooden dock that leads out into the ocean in the WEST.>
	indescription <You climb onto the motorbike.>
	north <OutsideLighthouse>
	south msg <There's nothing but grass and eventually the sea in that direction.>
	east <OutsideRuinedHouse>
	west <OutsideDock>
	northwest msg <There's nothing but grass and eventually the sea in that direction.>
	northeast msg <There's nothing but grass and eventually the sea in that direction.>
	southwest <OutsideLab>
	southeast <OutsideBeach>
end define

define room <OutsideLighthouse>
	alias <Northern Cliffs>
	look <The wind is fierce and cold here. The ground slopes gradually upwards to the cliff edge. A series of rocky pinnacles lead out into the sea, and an old lighthouse is built close to the drop.>
	indescription <You are outside the lighthouse, atop the:>
	north <LighthouseBottom>
	south msg <The rest of the island is laid out before you. But it's too far to walk to anywhere - you'll need transport.>

	define object <Motorbike3>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <If you had a key, you could start it, but you're no expert at hot-wiring.>
		prefix <a>
		article <it>
		gender <it>
		use <Key> {
			msg <You insert the key into the ignition and start the engine.>
			goto <Bike>
		}
	end define

	define object <Crucifix>
		alias <Crucifix>
		alt <cross; grave; gravestone; grave marker>
		look <It's a large wooden crucifix, set into the ground near the lighthouse - perhaps to mark a grave.>
		take {
			msg <You wrench the wooden crucifix from the ground.>
			hide <Crucifix>
			show <Crucifix2>
			give <Crucifix2>
		}
		examine <It's quite loose in the ground and could easily be removed.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Crucifix2>
		alias <Crucifix>
		alt <cross; grave; gravestone; grave marker>
		look <It's a large wooden crucifix. One end is muddy.>
		take <You pick up the wooden crucifix.>
		examine <It's quite light but fairly unwieldy.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		drop everywhere <You drop the crucifix to the ground with a clatter.>
	end define

end define

define room <OutsideRuinedHouse>
	alias <Overgrown Garden>
	look <This garden is overgrown with all manner of plants and is virtually unrecognisable as a garden, save for the fence around it. The gate is nowhere to be seen. A damp, abandoned house sits at the end of a weed-covered path to the east.>
	indescription <You find yourself in an:>
	east if flag <oldhouse> then {
		msg <You walk up the overgrown path and enter your uncle's old house.>
		goto <RealHall>
	}
	else {
		msg <You walk up the overgrown path. A sudden feeling of deja vu washes over you. As you reach the front door, the hairs stand up on the back of your neck. You realise that this house was your uncle's first house, before his inventions made him rich enough to afford his mansion. Your memory is flaky but you can vaguely remember spending whole summers here as a young child. The corporation must have built it's base on the same island. With a smile, you realise that you now know where you are. The mainland is about 50 miles to the north!>
		flag on <oldhouse>
		wait <Press any key to continue...>
		msg <You push open the old rusty front door and step into the long abandoned cottage. You begin to wonder what secrets your uncle might have left here, when suddenly the rotten floorboards give way under your feet and you plummet into the basement. You crack your head hard on the stairs and feel blood start to trickle down your face. The world fades to white...>
		lose <GPT>
		goto <RealBasement>
		goto <DreamBasement>
	}
	west msg <The rest of the island is laid out before you. But it's too far to walk to anywhere - you'll need transport.>

	define object <Motorbike4>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <If you had a key, you could start it, but you're no expert at hot-wiring.>
		prefix <a>
		article <it>
		gender <it>
		use <Key> {
			msg <You insert the key into the ignition and start the engine.>
			goto <Bike>
		}
	end define

end define

define room <OutsideBeach>
	alias <Beach>
	look <The scrubby grass on the island gives way to a sandy beach here. The tide is currently out and the sand stretches out serenely in front of you. A cave opens in the cliff to the north.>
	indescription <You are on a wide, sandy:>
	north <Cave>
	south msg <Walking into the ocean won't solve anything.>
	east msg <Walking into the ocean won't solve anything.>
	northwest msg <The rest of the island is laid out before you. But it's too far to walk to anywhere - you'll need transport.>
	northeast msg <Walking into the ocean won't solve anything.>
	southwest msg <Walking into the ocean won't solve anything.>
	southeast msg <Walking into the ocean won't solve anything.>

	define object <Motorbike5>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <If you had a key, you could start it, but you're no expert at hot-wiring.>
		prefix <a>
		article <it>
		gender <it>
		use <Key> {
			msg <You insert the key into the ignition and start the engine.>
			goto <Bike>
		}
	end define

end define

define room <OutsideDock>
	alias <Wooden Dock>
	look <You are standing on a solid wooden dock that stretches out into the sea. No boats are tied up although the dock looks in good shape and may well have been used recently.>
	indescription <You are on a creaky:>
	east msg <The rest of the island is laid out before you. But it's too far to walk to anywhere - you'll need transport.>
	northeast <Dockhouse>

	define object <Motorbike6>
		alias <Motorbike>
		alt <bike; motorcycle>
		look <It's a motorbike. You're not sure, but it looks quite high-powered. You are reminded of your uncle, who had a motorbike when he was younger, and taught you how to ride it.>
		take msg <It's a bit heavy to be dragging around.>
		examine <If you had a key, you could start it, but you're no expert at hot-wiring.>
		prefix <a>
		article <it>
		gender <it>
		use <Key> {
			msg <You insert the key into the ignition and start the engine.>
			goto <Bike>
		}
	end define

end define

define room <Cave>
	alias <Cave>
	look <This cave doesn't stretch very far into the cliff but it is dark and probably provides a home to bats.>
	indescription <This is a dark and craggy:>
	south <OutsideBeach>

	define object <Driftwood>
		alias <Driftwood>
		alt <wood; planks; boards>
		look <Several planks of driftwood, hardened by the salt water.>
		take <You pick up the driftwood pieces.>
		examine <They appear to come from old boats, and washed up at the back of the cave.>
		prefix <some>
		article <it>
		gender <it>
	end define

end define

define room <DreamBasement>
	alias <Basement>
	up {
		goto <DreamHall>
		flag off <inbasement>
	}
	script flag on <inbasement>
	description if flag <dreambasement> then msg <You find yourself in the cosy basement of your uncle's cottage. Various nautical memorabilia decorates the bare stone walls. Your uncle's writing desk sits against one wall. Old electric lamps light the room - their wires run around the walls. |n|nWooden stairs lead up into the house.> else {
		msg <You awaken slowly and focus on the room. Warm light fills your vision and you stand up. This is your uncle's cottage as you remember it - warm and cosy. Nautical memorabilia hangs from the walls along with some old-fashioned electronic lights. Your uncle's writing desk is positioned against the wall.|n|nWooden stairs lead up into the house.>
		flag on <dreambasement>
	}

	define object <Desk>
		alias <Desk>
		alt <papers>
		look <It's your uncle's writing desk. It's covered in bits of paper.>
		examine <The topmost note contains an odd riddle:|n|nBring the lofty bird beneath cool earth,|nBring light into the darkness,|nBring life to the flowing water,|nBring death to the flames,|nAnd I will come for you,|nI will come from the depths of sleep.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <DreamHall>
	alias <Hallway>
	look <You are in the hall of your uncle's house. Warm sunlight plays across the floor. You can hear birds singing in the garden to the west.|n|nStairs lead down into the basement, and another set leads upstairs.>
	indescription <You are in a warm, narrow:>
	north <DreamKitchen>
	south <DreamBathroom>
	east <DreamLivingRoom>
	west msg <The front door is firmly locked and you can find no way of opening it. Bright sunlight shines in through the oval window in it, almost blinding you.>
	up <DreamUpstairsLanding>
	down <DreamBasement>
	script {
		flag off <inbathroom>
		flag off <inbasement>
	}

	define object <Plant>
		alias <Plant>
		alt <pot; plant pot; flower>
		look <It's some kind of leafy green plant in a pot.>
		take <You pick up the plant pot.>
		examine <Some of the leaves are turning brown.>
		prefix <a>
		article <it>
		gender <it>
		use on <Sink2> {
			msg <You place the plant under the running tap.>
			hide <Plant>
			show <Sink3>
			hide <Sink2>
			flag on <life>
		}
	end define

end define

define room <DreamLivingRoom>
	alias <Living Room>
	look <This room is larger than the others in the house, and sports two comfy sofas. A fire is blazing in the fireplace.>
	indescription <You are in your uncle's:>
	west <DreamHall>

	define object <Fireplace>
		alias <Fireplace>
		alt <fire>
		look <A fire is blazing away merrily in the fireplace. It's very hot.>
		take msg <It's built into the wall.>
		examine <There's nothing on the mantelpiece or the hearth.>
		prefix <the>
		article <it>
		gender <it>
		use <Fossil> {
			msg <You place the fossil on the hearth in front of the roaring flames.>
			hide <Fossil>
			hide <Fireplace>
			show <Fireplace2>
			flag on <death>
		}
	end define

	define object <Fireplace2>
		alias <Fireplace>
		alt <fire>
		look <A fire is blazing away merrily in the fireplace. It's very hot.>
		take msg <It's built into the wall.>
		examine <There's nothing on the mantelpiece but you have placed the fossil on the hearth.>
		prefix <the>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <DreamKitchen>
	alias <Kitchen>
	look <The worktops are clean and unused. Your uncle was never one for cooking. All the appliances are here, exactly as you remember them.>
	indescription <You are in your uncle's sparse:>
	south <DreamHall>
	east <DreamDiningRoom>

	define object <Candle>
		alias <Candle>
		look <It's a large candle made of creamy-yellow wax.>
		take {
			msg <You pick up the candle.>
			flag off <candledown>
			give <Candle>
		}
		examine <It's never been lit.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Cigarette Lighter> if flag <candledown> then {
			msg <You carefully click the lighter on and hold the flame to the candle wick. It lights quickly and throws a dim light about the dark bathroom.>
			flag on <light>
			hide <Candle>
			show <Candle2>
		}
		else msg <It's not dark - there's no point lighting the candle.>
		drop if flag <inbathroom> then {
			msg <You place the candle on the ground.>
			lose <Candle>
			flag on <candledown>
		}
		else {
			msg <You place the candle on the ground.>
			lose <Candle>
		}
	end define

	define object <Cupboard>
		alias <Cupboard>
		alt <cabinet; unit>
		look <This cupboard contains nothing except for one candle.>
		examine choose <takecandle>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Cupboard2>
		alias <Cupboard>
		alt <cabinet; unit>
		look <This cupboard is completely empty.>
		take msg <It's firmly screwed to the wall.>
		examine <There's nothing else in the cupboard to take.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

	define object <Sink>
		alias <Sink>
		look <It's a standard kitchen sink. It has one tap for both hot and cold water. The water is not running.>
		take msg <I'm not going to do the old 'everything but the kitchen sink joke'. Suffice to say, it's quite firmly attached to the kitchen worktop, not to mention the plumbing.>
		examine choose <turnwateron>
		prefix <the>
		article <it>
		gender <it>
	end define

	define object <Sink2>
		alias <Sink>
		look <It's a standard kitchen sink. It has one tap for both hot and cold water. Water is running from it.>
		take msg <I'm not going to do the old 'everything but the kitchen sink joke'. Suffice to say, it's quite firmly attached to the kitchen worktop, not to mention the plumbing.>
		examine choose <turnwateroff>
		prefix <the>
		article <it>
		gender <it>
		hidden
	end define

	define object <Sink3>
		alias <Sink>
		look <It's a standard kitchen sink. It has one tap for both hot and cold water. Water is running from it over a leafy pot plant.>
		take msg <The plant is fine where it is.>
		examine <The plant is getting soaked in water. There's not much more you can do with it.>
		prefix <the>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <DreamDiningRoom>
	alias <Dining Room>
	look <This room features an elegant long dining table that your uncle later took to his mansion. A fruit bowl adorns the cabinet in the corner.>
	indescription <You make your way into the:>
	west <DreamKitchen>

	define object <Fossil>
		alias <Fossil>
		alt <bone; rock>
		look <This is a piece of rock containing the fossilised remains of a long-time trilobyte. It's quite heavy.>
		take <You pick up the fossil.>
		examine <It's definitely genuine, your uncle got it on an archaelogical dig in Mexico.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <DreamUpstairsLanding>
	alias <Landing>
	look <This landing is small and gives way to two doors. The stair rail ends in an elegant wooden post.>
	indescription <You are at the top of the stairs, on the:>
	north <DreamGuestBedroom>
	east <DreamUnclesBedroom>
	down <DreamHall>

	define object <Flying Ducks>
		alias <Flying Ducks>
		alt <Ducks; duck; flying duck>
		look <It's a set of three plaster ducks flying up the wall. Your uncle probably thought it was fashionable decoration at some point.>
		take {
			msg <You prise the loose duck from the wall.>
			hide <Flying Ducks>
			show <Flying Ducks2>
			show <Flying Duck>
			give <Flying Duck>
		}
		examine <One of the ducks is quite loose.>
		prefix <a set of>
		article <them>
		gender <it>
	end define

	define object <Flying Ducks2>
		alias <Flying Ducks>
		alt <Ducks; duck; flying duck>
		look <It's a set of two plaster ducks flying up the wall. One of them is missing. Your uncle probably thought it was fashionable decoration at some point.>
		take msg <The other two ducks are quite happy where they are.>
		examine <There's a section of unfaded wallpaper where the third duck used to be.>
		prefix <a set of>
		article <them>
		gender <it>
		hidden
	end define

	define object <Flying Duck>
		alias <Flying Duck>
		alt <Ducks; duck; flying ducks>
		look <It's a plaster duck in the middle of flapping it's wings. Your uncle probably thought it was fashionable decoration at some point.>
		take msg <You pick up the plaster duck.>
		examine <There's nothing special about it, in fact it's quite tacky.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		drop if flag <inbasement> then {
			msg <You place the plaster duck on the ground in the basement.>
			lose <Flying Duck>
			flag on <bird>
		}
		else {
			msg <You place the flying duck on the ground.>
			lose <Flying Duck>
		}
	end define

end define

define room <DreamUnclesBedroom>
	alias <Master Bedroom>
	look <This is your uncle's bedroom. It has a large unmade four-poster bed in it and has a great view out over the ocean.>
	indescription <You are in your uncle's:>
	west <DreamUpstairsLanding>
	script if flag <life> and flag <death> and flag <light> and flag <bird> then {
		msg <As you enter your uncle's bedroom, you are startled by the figure of your uncle himself, sitting on the bedside.>
		show <Uncle>
	}
	else msg <As you enter your uncle's bedroom you feel a sudden cold wind.>

	define object <Uncle>
		alias <Uncle>
		look <Your uncle looks a lot younger than at the time of his death. He is wearing a mournful expression on his face.>
		take msg <You can't pick up your uncle!>
		speak {
			msg <'Uncle,' you begin, and your uncle looks up at you.|n|n'Ah my child,' he says with a sad smile, 'It is good to see you again.'|n|n'I've missed you uncle,' you say and move towards him.|n|nHe puts out a hand to stop you and you do so, confused.|n|n'I was murdered,' he says, 'Murdered by a corporation so greedy they wanted to develop a chemical for use in assassinating their rivals, politicians, powerful businessmen and the like. With the power to kill someone and leave no evidence, they could gain control of everything. You must avenge my death. You must bring the corporation to justice. It's up to you, you're the only one who knows. Will you help me find peace?'>
			wait <Press any key to continue...>
			choose <unclequestion1>
		}
		examine <He's wearing his old red dressing gown and worn-down slippers.>
		prefix <your>
		displaytype <character>
		article <them>
		gender <he>
		hidden
	end define

	define object <Uncle2>
		alias <Uncle>
		look <Your uncle looks a lot younger than at the time of his death. He is wearing a mournful expression on his face.>
		take msg <You can't pick up your uncle!>
		speak {
			msg <'Ah my child,' says your uncle, 'Have you reconsidered? Please help me find rest, and bring the corporation to justice.'>
			wait <Press any key to continue...>
			choose <unclequestion1>
		}
		examine <He's wearing his old red dressing gown and worn-down slippers.>
		prefix <your>
		displaytype <character>
		article <them>
		gender <he>
		hidden
	end define

end define

define room <DreamGuestBedroom>
	alias <Guest Bedroom>
	look <The decor is very plain and tasteful in here. This used to be where you slept when you came to visit your uncle.>
	indescription <This is your uncle's:>
	south <DreamUpstairsLanding>

	define object <Cigarette Lighter>
		alias <Cigarette Lighter>
		alt <lighter>
		look <It's a standard disposable cigarette lighter. Your uncle wasn't a heavy smoker but he occasionally indulged in a cigar.>
		take <You grab the lighter.>
		examine <It's full of lighter fluid and readily lights.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <RealBasement>
	alias <Basement>
	look <You are in the dingy basement of your uncle's old cottage. The only light is coming from sunlight seeping down the stairwell and through the hole where you fell down here. The whole place smells of damp and rot. Your possessions have fallen all over the floor here.>
	up <RealHall>
	script flag on <inrealbasement>
	description if flag <dreamover> then msg <You are in the dingy basement of your uncle's old cottage. The only light is coming from sunlight seeping down the stairwell and through the hole where you fell down here. The whole place smells of damp and rot. Your possessions have fallen all over the floor here.> else msg <You are in a dingy basement. Blood is clouding your vision...>

	define object <RealDesk>
		alias <Desk>
		look <This desk of your uncles is still here. He must not have taken it with him when he left.>
		take msg <It's too heavy to move.>
		examine <A wet piece of paper is all that's left on the desk now. The ink has run but you can just make out the riddle:|n|nBring the lofty bird beneath cool earth,|nBring light into the darkness,|nBring life to the flowing water,|nBring death to the flames,|nAnd I will come for you,|nI will come from the depths of sleep.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <DreamBathroom>
	alias <Bathroom>
	look <This functional bathroom features a bath with a shower attachment, a sink and a small window, as well as the toilet of course. There are no windows and it is dark in here.>
	indescription <This is the small:>
	north {
		goto <DreamHall>
		flag off <inbathroom>
	}
	script flag on <inbathroom>

	define object <Candle2>
		alias <Candle>
		look <It's a large candle made of creamy-yellow wax.>
		take msg <The candle is lit. There's nothing more you can do with it.>
		examine <It's never been lit.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		drop if flag <inbathroom> then {
			msg <You place the candle on the ground.>
			lose <Candle>
			flag on <candledown>
		}
		else {
			msg <You place the candle on the ground.>
			lose <Candle>
		}
	end define

end define

define room <Light>
	alias <Light>
	look <All around you is so brightly lit it is white. Slowly, the light fades and you find yourself in the darkness of the basement.|n|nYour uncle's voice whispers in the air... 'Avenge me!'>
	indescription <You are in the midst of a bright, white:>
	script {
		flag on <dreamover>
		goto <RealBasement>
		hide <Cigarette Lighter>
		hide <Candle2>
		hide <Plant>
		hide <Candle>
		hide <Flying Duck>
		hide <Fossil>
	}
end define

define room <RealHall>
	alias <Hallway>
	look <The walls are black with mould and the floorboards are mossy and weak. The weakest part has already given way beneath you, leaving a large hole in the floor. Rickety stairs lead up and down and several rotten doorways, long since bereft of doors, lead out of here.>
	indescription <You have entered a rotted:>
	north <RealKitchen>
	south <RealBathroom>
	east <RealLivingRoom>
	west if flag <light2> and flag <death2> and flag <gull2> and flag <life2> then {
		msg <With a breath of wind that sounds like a sigh, the door clicks open and you emerge into the daylight.>
		goto <OutsideRuinedHouse>
	}
	else msg <You gingerly step around the hole in the floor and try the front door. It's locked!>
	up <RealUpstairsLanding>
	down <RealBasement>
	script {
		flag off <inrealbasement>
		flag off <inrealbathroom>
		if flag <death2> and flag <life2> and flag <light2> and flag <bird2> then {
			msg <As you enter the hallway, you feel a cold wind blow past you. The house's front door clicks and swings open with a long creak.>
			create exit west <RealHall; OutsideRuinedHouse>
		}
		else msg <It's cold in the hallway.>
	}

	define object <Bedroll>
		alias <Bedroll>
		alt <bed; roll>
		look <This grubby bedroll seems to have been placed here by squatters a long time ago.>
		take msg <I wouldn't pick that up if I were you - it's filthy.>
		examine <It's filthy dirty, I wouldn't get too close.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <RealLivingRoom>
	alias <Living Room>
	look <This room is empty save for a large blackened fireplace. It is dark and dingy in here, and mould is growing on the walls.>
	indescription <You are the remains of a:>
	west <RealHall>

	define object <RealFireplace>
		alias <Fireplace>
		alt <fire>
		look <This fireplace has seen better days. The mantelpiece is cracked and the hearth black and disused.>
		take msg <It's built into the wall.>
		examine <There's no kindling in the fireplace to make a fire.>
		prefix <a>
		article <it>
		gender <it>
		use <Chairleg> {
			msg <You put the chair leg in the fireplace.>
			hide <Chairleg>
			hide <RealFireplace>
			show <RealFireplace2>
		}
	end define

	define object <RealFireplace2>
		alias <Fireplace>
		alt <fire; chairleg; chair leg; chair; leg>
		look <This fireplace has seen better days. The mantelpiece is cracked and the hearth black and disused.>
		take {
			msg <You pick up the chair leg from the hearth.>
			show <Chairleg>
			give <Chairleg>
			show <RealFireplace2>
			show <RealFireplace>
		}
		examine <There's a chairleg on the hearth.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Cigarette Lighter2> {
			msg <You flick the lighter on and carefully set fire to the chairleg. You find more bits of debris from around the room and soon have a small fire going.>
			hide <RealFireplace2>
			show <RealFireplace3>
		}
	end define

	define object <RealFireplace3>
		alias <Fireplace>
		alt <fire; chairleg; chair leg; chair; leg>
		look <This fireplace has seen better days. The mantelpiece is cracked.>
		take msg <It's built into the wall.>
		examine <There's a small fire burning in the hearth.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Finger> {
			msg <You place the severed finger on the hearth right by the flames.>
			flag on <death2>
			hide <RealFireplace3>
			hide <Finger>
			show <RealFireplace4>
		}
	end define

	define object <RealFireplace4>
		alias <Fireplace>
		alt <fire; chairleg; chair leg; chair; leg>
		look <This fireplace has seen better days. The mantelpiece is cracked.>
		take msg <It's built into the wall.>
		examine <There's a small fire burning in the hearth. A severed finger sits next to it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <RealKitchen>
	alias <Kitchen>
	look <This kitchen has seen better days. Most of the appliances are missing and the cupboards are hanging off their hinges. Muck and dirt cover the floor.>
	indescription <You are in a dilapidated:>
	south <RealHall>
	east <RealDiningRoom>

	define object <Rag>
		alias <Rag>
		alt <cloth>
		look <It's a dry cotton rag.>
		take <You take the cotton rag.>
		examine <There's nothing special about it except that it's dry, which seems to be rare in this damp house.>
		prefix <a>
		article <it>
		gender <it>
		use on <Bottle of Vodka> {
			msg <You soak the rag in vodka then insert it into the bottle.>
			hide <Bottle of Vodka>
			hide <Rag>
			show <Bottle of Vodka2>
			give <Bottle of Vodka2>
		}
	end define

	define object <RealSink>
		alias <Sink>
		look <It's a battered old sink. The plumbing's disconnected.>
		take msg <You can't take that, it's attached to the worktop.>
		examine <Turning the tap results in a dry squeaking noise and nothing else. You could get more water by wringing out the wallpaper.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <RealDiningRoom>
	alias <Dining Room>
	look <The walls here are as damp as the rest of the house. Some form of creeping ivy has worked it's way in through a crack in the window and covered most of the floor. A broken chair lies forlornly in the corner.>
	indescription <You find yourself in a rotted:>
	west <RealKitchen>

	define object <Chairleg>
		alias <Chair Leg>
		alt <chair; leg; wood; kindling>
		look <It's a broken chair leg. Miraculously it's stayed quite dry.>
		take <You pick up the broken chair leg.>
		examine <It's quite sharp at the end where it snapped off - you could get a splinter if you're not careful.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Ivy>
		alias <Ivy>
		alt <vine; plant>
		look <It's a huge growth of ivy that's come in through the window.>
		take msg <The plant is massive, you can't just uproot it.>
		examine <There's nothing exciting about it - it's barely alive due to lack of water and sunlight - this room seems to be drier than the rest of the house.>
		prefix <some>
		article <it>
		gender <it>
	end define

	define object <Ivy2>
		alias <Ivy>
		alt <vine; plant>
		look <It's a huge growth of ivy that's come in through the window.>
		take msg <The plant is massive, you can't just uproot it.>
		examine <There's nothing exciting about it - it's barely alive due to lack of water and sunlight but now water is running over it from a hole in the ceiling.>
		prefix <some>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <RealUpstairsLanding>
	alias <Landing>
	look <The wallpaper is hanging off the walls, revealing bare grey plaster behind. Mildew covers every surface and there are many dents and holes in the plaster. At least the floorboards up here seem a bit more solid.>
	indescription <You have entered a dingy:>
	north <RealGuestBedroom>
	east <RealUnclesBedroom>
	down <RealHall>

	define object <Cigarette Lighter2>
		alias <Cigarette Lighter>
		alt <lighter>
		look <It's a standard disposable cigarette lighter.>
		take <You grab the lighter.>
		examine <It's full of lighter fluid and readily lights.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <RealUnclesBedroom>
	alias <Master Bedroom>
	look <This bedroom once sported a nice view, but the window has been boarded up. Thin shafts of light can barely be bothered to creep into the room between the nailed-up planks.>
	indescription <You are in a dark, musty:>
	west <RealUpstairsLanding>

	define object <Dead Seagull>
		alias <Dead Seagull>
		alt <Seagull; gull; bird; dead gull; dead bird>
		look <It's the body of a seagull. Somehow it must have found it's way in here and become trapped. It's starting to rot.>
		take <You gingerly pick up the vile corpse.>
		examine <It's quite disgusting and smells very bad.>
		prefix <a>
		article <it>
		gender <it>
		drop if flag <inrealbasement> then {
			msg <You place the squishy bird corpse on the floor.>
			lose <Dead Seagull>
			flag on <gull2>
		}
		else {
			msg <You place the squishy bird corpse on the floor.>
			lose <Dead Seagull>
		}
	end define

end define

define room <RealGuestBedroom>
	alias <Guest Bedroom>
	look <The walls are covered with mould in here, and a trickle of water is slowly working it's way down from the roof in a thin line and collecting in a puddle on the cracked tiles of the floor. Dirty newspaper has been squashed into the floor with the dampness of the place.>
	indescription <You are in a forlorn and run-down:>
	south <RealUpstairsLanding>

	define object <Puddle>
		alias <Puddle>
		alt <floor; crack; tile; tiles>
		look <This puddle is where water is collecting in a weak point in the tile floor.>
		take msg <You want to take a puddle?>
		examine <The floor looks very weak. You could break a hole through to the room below if you had some kind of weapon.>
		prefix <a>
		article <it>
		gender <it>
		use <Chairleg> {
			msg <You use the chair leg to beat the floor under the puddle. In no time at all, your blows knock a great chunk of the tiled floor down into the dining room below, and water starts trickling through the gap.>
			hide <Puddle>
			show <Puddle2>
			hide <Ivy>
			show <Ivy2>
			flag on <life2>
		}
		use <Machine Gun> {
			hide <Puddle>
			show <Puddle2>
			hide <Ivy>
			show <Ivy2>
			flag on <life2>
			msg <You step back and carefully shoot the floor beneath the puddle. The force of the shots is enough to loosen the plaster and a great chunk of it falls into the dining room below, leaving a gaping hole through which water is running freely.>
		}
	end define

	define object <Puddle2>
		alias <Hole>
		alt <floor; crack; tile; tiles; puddle>
		look <This is a rough hole in the floor.>
		take msg <You can't pick up a hole in this dimension...>
		examine <Water is running through the rough hole in the floor and into the dining room.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <RealBathroom>
	alias <Bathroom>
	look <It's almost pitch black in here. You can just see that everything's broken and there is no water coming to any of the fittings.>
	indescription <You are in a dark:>
	north <RealHall>
	script flag on <inrealbathroom>

	define object <Bottle of Vodka>
		alias <Bottle of Vodka>
		alt <bottle; vodka>
		look <This bottle is full of a clear liquid that smells like vodka.>
		take <You pick up the bottle.>
		examine <You're not about to drink any to make sure it's vodka.>
		prefix <a>
		article <it>
		gender <it>
	end define

	define object <Bottle of Vodka2>
		alias <Bottle of Vodka>
		alt <bottle; vodka>
		look <This bottle is full of a clear liquid that smells like vodka. There is a wet rag stuffed into the top of the bottle.>
		take <You pick up the bottle.>
		examine <You're not about to drink any to make sure it's vodka.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Cigarette Lighter2> {
			msg <You easily set fire to the cotton rag and make yourself a volatile and dangerous light source.>
			hide <Bottle of Vodka2>
			show <Bottle of Vodka3>
			give <Bottle of Vodka3>
		}
	end define

	define object <Bottle of Vodka3>
		alias <Flaming Bottle>
		alt <bottle; vodka>
		look <This bottle is full of a clear liquid that smells like vodka. There is a wet rag stuffed into the top of the bottle. It's on fire.>
		take <You pick up the bottle.>
		examine <It's too hot to examine closely.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Cigarette Lighter2> {
			msg <You easily set fire to the cotton rag and make yourself a volatile and dangerous light source.>
			hide <Bottle of Vodka2>
		}
		drop if flag <inrealbathroom> then {
			msg <You place the flaming bottle on the floor.>
			lose <Bottle of Vodka3>
			flag on <light2>
		}
		else {
			msg <You place the flaming bottle on the floor.>
			lose <Bottle of Vodka3>
		}
	end define

	define object <Sheet>
		alias <Sheet>
		alt <sail>
		look <This is a large white sheet - it looks like it would fit a single bed. It's relatively free of damp and mould.>
		take <You pick up the folded sheet.>
		examine <It's in pretty good condition - there are no holes in it and the damp has barely started to rot it.>
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <Dockhouse>
	alias <Dockhouse>
	look <This cramped wooden building houses boats when they're not in use. It's been disused for a long time.>
	indescription <This is a small, rickety:>
	southwest <OutsideDock>

	define object <Rowboat>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat won't get very far - it's got a hole in the bottom that appears to have been gouged there by a rock at some point.>
		take {
			if flag <boatoutside> then msg <There's nowhere else to take it.> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		speak <It creaks gently but says nothing.>
		examine <This boat is old and damaged, but if you were to fix it, you could get off this island.>
		prefix <a>
		article <it>
		gender <it>
		use <Driftwood> {
			msg <You jam the pieces of wood into place to cover the hole in the boat. But they won't stay like that - they need fixing to the boat properly somehow.>
			hide <Rowboat>
			show <Rowboat2>
			hide <Driftwood>
		}
	end define

	define object <Rowboat2>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat won't get very far - it's got a hole in the bottom and although it has been plugged with driftwood, it won't hold.>
		take {
			if flag <boatoutside> then msg <There's nowhere else to take it.> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		speak <It creaks gently but says nothing.>
		examine <If you could fix it, this boat could become a serviceable vehicle.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <BeakerBYR2> {
			msg <You pour the sticky liquid over the driftwood. The glue-like substance soon sticks the driftwood firmly over the hole, plugs the boat up and makes it watertight.>
			hide <Rowboat2>
			show <Rowboat3>
			hide <BeakerBYR2>
			show <Beaker>
			give <Beaker>
		}
	end define

	define object <Rowboat3>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat is watertight, but it needs some way of powering it.>
		take {
			if flag <boatoutside> then msg <There's nowhere else to take it.> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		speak <It creaks gently but says nothing.>
		examine <This boat still won't make it very far, not unless you fancy rowing with your hands.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Crucifix2> {
			msg <You lodge the crucifix in the boat as a make-shift mast. It won't hold like that though.>
			hide <Crucifix2>
			hide <Rowboat3>
			show <Rowboat4>
		}
	end define

	define object <Rowboat4>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat is watertight, but it needs some way of powering it. A mast is loosely leaned in the boat.>
		take {
			if flag <boatoutside> then msg <There's nowhere else to take it.> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		speak <It creaks gently but says nothing.>
		examine <This boat still won't make it very far off this island, unless you fancy rowing with your hands.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <rope> {
			msg <You lash the mast to the boat with the length of rope and make sure it is securely fastened.>
			hide <Rowboat4>
			hide <rope>
			show <Rowboat5>
		}
	end define

	define object <Rowboat5>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat is watertight, but it needs some way of powering it. A mast is tied firmly in the centre.>
		take {
			if flag <boatoutside> then msg <There's nowhere else to take it.> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		examine <This boat still won't go anywhere without some method of locomotion.>
		prefix <a>
		article <it>
		gender <it>
		hidden
		use <Sheet> {
			msg <You firmly tie the white sheet around the spar of the crucifix to create a sail. The remaining rope is useful to tie up or down the sail as needed.>
			hide <Rowboat5>
			hide <Sheet>
			show <Rowboat6>
		}
	end define

	define object <Rowboat6>
		alias <Rowboat>
		alt <boat; rowing boat>
		look <This rowing boat is watertight, and has a sail to power it. The wind is picking up.>
		take {
			if flag <boatoutside> then goto <Ocean> else {
				msg <You drag the old rowing boat out of the boathouse and onto the dock.>
				move <Rowboat; OutsideDock>
				move <Rowboat2; OutsideDock>
				move <Rowboat3; OutsideDock>
				move <Rowboat4; OutsideDock>
				move <Rowboat5; OutsideDock>
				move <Rowboat6; OutsideDock>
				goto <OutsideDock>
				flag on <boatoutside>
			}
		}
		speak <It creaks gently but says nothing.>
		examine <This boat is now a proper vehicle, and you should be able to get somewhere in it.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <LighthouseBottom>
	alias <Lighthouse>
	look <This is the base of the old lighthouse. The lighthouse is shut down and the broken and rusted generator for it sits forlornly in the corner. A flight of rickety stairs leads to the top of the lighthouse, where the light is located.>
	indescription <You are at the bottom of an old:>
	south <OutsideLighthouse>
	up <LighthouseTop>

	define object <Generatorlighthouse>
		alias <Generator>
		alt <broken generator>
		look <It's broken and very rusty. It obviously hasn't been used in a long time.>
		take msg <It's massive and bolted to the floor.>
		examine <There's no way of getting it working now - it would need to be completely replaced if it were ever to power the lighthouse again.>
		prefix <the lighthouse's>
		article <it>
		gender <it>
	end define

	define object <Security Map3>
		alias <Tattered Map>
		alt <map 001; map 1>
		look picture <map3.jpg>
		take <You pick up the old map.>
		speak <It doesn't talk.>
		examine <If you want to view the map, just look at it.>
		prefix <a>
		article <it>
		gender <it>
		use picture <map3.jpg>
		use anything msg <You can't use that on the map.>
		use on anything msg <How is that going to achieve anything?>
	end define

	define object <rope>
		alias <Rope>
		look <It's a decent length of well-crafted rope.>
		take <You pick up the rope - it'll almost certainly prove useful.>
		examine <It's been waterproofed somehow, as it isn't fraying or even getting wet in the damp conditions of this island.>
		prefix <a length of>
		article <it>
		gender <it>
		hidden
	end define

	define object <Platform2>
		alias <Platform>
		look <It's a metal platform, dented out of shape. It was once a sort of lift but it has broken.>
		take msg <You have no need for a heavy metal platform.>
		examine <There's nothing special about it, the rope has come untied.>
		prefix <a>
		article <it>
		gender <it>
		hidden
	end define

end define

define room <LighthouseTop>
	alias <Lighthouse>
	look <You are on the top floor of the lighthouse. A huge dead light is the central feature of this room. It has rusted into place and is completely useless.>
	indescription <You have climbed to the top of the:>
	down <LighthouseBottom>

	define object <lighthouselight>
		alias <Light>
		alt <lamp>
		look <It's a massive electric lamp, designed for ensuring safe passage for ships at sea. It's broken and rusted beyond repair.>
		take msg <It's a massive light, nearly as big as you - you can't lift it.>
		examine <It's completely useless and cannot be repaired. The only thing still in one piece is the glass which miraculously hasn't smashed.>
		prefix <the>
		article <it>
		gender <it>
	end define

	define object <Platform>
		alias <Platform>
		look <It's a sort of primitive lift - it's a metal platform suspended from a rope which passes through a rusty pulley in the ceiling. The other end of the rope is wrapped around a metal post.>
		take {
			msg <You pull on the rope, but the lift has not been used in ages, and the rusty pulley rips out of the flaking ceiling and the entire contraption plummets to the floor far below.>
			hide <Platform>
			show <Platform2>
			show <rope>
		}
		examine {
			msg <You pull on the rope, but the lift has not been used in ages, and the rusty pulley rips out of the flaking ceiling and the entire contraption plummets to the floor far below.>
			hide <Platform>
			show <Platform2>
			show <rope>
		}
		prefix <a>
		article <it>
		gender <it>
	end define

end define

define room <Ocean>
	look <You are sailing across the ocean towards the mainland.>
	indescription <This is the big, blue:>
	script if got <DVD-ROM2> then playerwin else playerlose
end define

define timer <strengthpotiontimelast>
	interval <40>
	action {
		flag off <playerstrong>
		msg <The effects of the strength potion have worn off.>
		timeroff <strengthpotiontimelast>
	}
	disabled
end define

define timer <weaknesspotiontimelast>
	interval <40>
	action {
		msg <The effects of the weakness potion have worn off.>
		flag off <playerweak>
		timeroff <weaknesspotiontimelast>
	}
	disabled
end define

define timer <steadypotiontimelast>
	interval <50>
	action {
		flag off <steady>
		msg <You feel the effects of the steadiness potion wearing off. Your muscles return to their normal state and you feel slightly shaky for a moment before regaining control.>
		timeroff <steadypotiontimelast>
	}
	disabled
end define

define timer <shakypotiontimelast>
	interval <30>
	action {
		flag off <shaky>
		msg <The effects of the strange shaking potion have worn off.>
		timeroff <shakypotiontimelast>
	}
	disabled
end define

define text <intro>

end define

define text <win>
You launch your small sailing boat into the water and head for the mainland. The wind picks up and soon you are leaving that godforsaken island behind. Suddenly, a huge bang erupts behind you. You turn in time to feel a blastwave of heat. A huge fireball is rising over the Corporation facility. In horror, you realise that if you had left ten minutes later, you would be dead. The base must have had some sort of self-destruct mechanism in order to destroy any evidence.

Then you smile to yourself, knowing that you have a disk full of incriminating evidence against the corporation, and nothing will stop you bringing the corporation to justice.

You feel a sudden rush of cold air, and there, on the edge of hearing, might just be a whisper:

'Thank you...'

THE END
----------
end define

define text <lose>
You launch your small sailing boat into the water and head for the mainland. The wind picks up and soon you are leaving that godforsaken island behind. Your plan is to get the authorities down on this place and expose the corporation. Suddenly, a huge bang erupts behind you. You turn in time to feel a blastwave of heat. A huge fireball is rising over the Corporation facility. Some kind of self-destruct mechanism has been activated!

All the evidence of the atrocities committed on the island has been destroyed! You can't believe it - there's now no way of proving the corporation had anything to do with your uncle's death or anything else for that matter.

You grit your teeth in frustration as an icy blast of wind almost throws you into the water...

THE END
----------
end define

define selection <Retrieve processor from locker>
	info <Do you wish to take a processor?>
	choice <Yes> {
		msg <You remove a processor from the cupboard and put it in your pocket.>
		hide <Locked Cupboard2>
		hide <Locked Cupboard4>
		show <Processor>
		give <Processor>
		show <Locked Cupboard3>
	}
	choice <No> msg <You leave the locker alone.>
end define
define selection <Turn on PC>
	info <Do you wish to switch the computer on?>
	choice <Yes> if flag <readreport> then {
		msg <You turn on the computer. It starts booting up...>
		choose <Safe Mode?>
	}
	else {
		msg <The computer boots up. Soon the security card reader light flashes on. The computer is operational.>
		hide <Computer>
		show <badComputer>
	}
	choice <No> msg <You leave the computer as it is.>
end define
define selection <Safe Mode?>
	info <How do you wish to boot the computer?>
	choice <Normally> {
		msg <You boot up the computer in normal mode and presently the security card reader lights come on. The computer is fully operational.>
		hide <Computer>
		show <badComputer>
	}
	choice <Safe Mode> {
		msg <You select to boot up in safe mode. The computer takes a bit longer to load up, but eventually the security card reader turns on.>
		hide <Computer>
		show <goodComputer>
	}
end define
define selection <Turn Off PC>
	info <Do you wish to turn the computer off?>
	choice <Yes> {
		msg <You turn the computer off.>
		hide <badComputer>
		hide <goodComputer>
		show <Computer>
	}
	choice <No> msg <You leave the computer as it is.>
end define
define selection <take lift up>
	info <Do you wish to ride the elevator to the top?>
	choice <Yes> {
		msg <You enter the lift and press the Up button. The lift rattles to the top and you step out.>
		goto <Delivery Bay>
	}
	choice <No> msg <You stay in the warehouse.>
end define
define selection <drop potion>
	info <Do you wish to put the flask down or tip away the liquid?>
	choice <Put down the flask.> msg <This flask is useful for mixing potions. Don't lose it!>
	choice <Tip away the contents of the flask.> {
		show <Beaker>
		give <Beaker>
		hide <BeakerRBY1>
		hide <BeakerRYB1>
		hide <BeakerBRY1>
		hide <BeakerBYR1>
		hide <BeakerYRB1>
		hide <BeakerYBR1>
		hide <BeakerRBY2>
		hide <BeakerRYB2>
		hide <BeakerBRY2>
		hide <BeakerBYR2>
		hide <BeakerYRB2>
		hide <BeakerYBR2>
		msg <You tip your potion away, leaving the flask free for making another potion in.>
	}
	choice <Neither.> msg <You hold onto your flask for the time being.>
end define
define selection <take lift down>
	info <Do you wish to ride the elevator down?>
	choice <Yes> {
		msg <You enter the rickety elevator and hit the Down button. The metal cage descends into the huge warehouse.>
		goto <Warehouse>
	}
	choice <No> msg <You stay in the delivery bay.>
end define
define selection <power cycles>
	info <Do you wish to reset the power for Area A?>
	choice <Yes> {
		msg <You pull the generator's main power lever and the lights dim and fade out. In the dim light from the high windows, you can just about see what you are doing as you push the lever back up. The generator begins to hum and presently all the lights fade on. All systems have been reset to their default settings.>
		hide <Generator2>
		show <Generator3>
		create exit east <upstairs north east hallway; Barracks>
		create exit south <Generator Room; northeast north-south hallway2>
	}
	choice <No> msg <You leave the generator alone.>
end define
define selection <safedigit1>
	info <What is the first digit?>
	choice <0> choose <safedigit2>
	choice <1> choose <safedigit2>
	choice <2> choose <safedigit2>
	choice <3> choose <safedigit2>
	choice <4> choose <safedigit2>
	choice <5> choose <safedigit2>
	choice <6> choose <safedigit2>
	choice <7> {
		flag on <digit1>
		choose <safedigit2>
	}
	choice <8> choose <safedigit2>
	choice <9> choose <safedigit2>
end define
define selection <safedigit2>
	info <What is the second digit?>
	choice <0> choose <safedigit3>
	choice <1> choose <safedigit3>
	choice <2> {
		flag on <digit2>
		choose <safedigit3>
	}
	choice <3> choose <safedigit3>
	choice <4> choose <safedigit3>
	choice <5> choose <safedigit3>
	choice <6> choose <safedigit3>
	choice <7> choose <safedigit3>
	choice <8> choose <safedigit3>
	choice <9> choose <safedigit3>
end define
define selection <safedigit3>
	info <What is the third digit?>
	choice <0> choose <safedigit4>
	choice <1> {
		flag on <digit3>
		choose <safedigit4>
	}
	choice <2> choose <safedigit4>
	choice <3> choose <safedigit4>
	choice <4> choose <safedigit4>
	choice <5> choose <safedigit4>
	choice <6> choose <safedigit4>
	choice <7> choose <safedigit4>
	choice <8> choose <safedigit4>
	choice <9> choose <safedigit4>
end define
define selection <safedigit4>
	info <What is the fourth digit?>
	choice <0> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <1> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <2> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <3> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <4> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <5> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <6> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <7> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <8> if flag <digit1> and flag <digit2> and flag <digit3> then {
		msg <You turn the last number to 8, and the lock clicks then releases. The safe swings open.>
		hide <Safe>
		show <Safe2>
	}
	else {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
	choice <9> {
		msg <That combination didn't work.>
		flag off <digit1>
		flag off <digit2>
		flag off <digit3>
	}
end define
define selection <Hearts>
	info <What number will you choose for hearts?>
	choice <1> choose <Spades>
	choice <2> choose <Spades>
	choice <3> choose <Spades>
	choice <4> choose <Spades>
	choice <5> choose <Spades>
	choice <6> choose <Spades>
	choice <7> choose <Spades>
	choice <8> choose <Spades>
	choice <9> choose <Spades>
	choice <10> choose <Spades>
	choice <11> choose <Spades>
	choice <12> choose <Spades>
	choice <13> {
		flag on <hearts>
		choose <Spades>
	}
end define
define selection <Spades>
	info <What number will you choose for spades?>
	choice <1> choose <Clubs>
	choice <2> choose <Clubs>
	choice <3> choose <Clubs>
	choice <4> choose <Clubs>
	choice <5> choose <Clubs>
	choice <6> choose <Clubs>
	choice <7> {
		flag on <spades>
		choose <Clubs>
	}
	choice <8> choose <Clubs>
	choice <9> choose <Clubs>
	choice <10> choose <Clubs>
	choice <11> choose <Clubs>
	choice <12> choose <Clubs>
	choice <13> choose <Clubs>
end define
define selection <Clubs>
	info <What number will you choose for clubs?>
	choice <1> {
		flag on <clubs>
		choose <Diamonds>
	}
	choice <2> choose <Diamonds>
	choice <3> choose <Diamonds>
	choice <4> choose <Diamonds>
	choice <5> choose <Diamonds>
	choice <6> choose <Diamonds>
	choice <7> choose <Diamonds>
	choice <8> choose <Diamonds>
	choice <9> choose <Diamonds>
	choice <10> choose <Diamonds>
	choice <11> choose <Diamonds>
	choice <12> choose <Diamonds>
	choice <13> choose <Diamonds>
end define
define selection <Diamonds>
	info <What number will you enter for diamonds?>
	choice <1> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <2> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <3> if flag <hearts> and flag <clubs> and flag <spades> then {
		msg <You set the last digit to 3, and the electronic lock beeps, then buzzes as the locker door slides open.>
		hide <Security Locker>
		show <Security Locker2>
	}
	else {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <4> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <5> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <6> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <7> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <8> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <9> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <10> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <11> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <12> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
	choice <13> {
		msg <You enter the last digit. The electronic lock beeps at you to tell you the combination is wrong.>
		flag off <hearts>
		flag off <spades>
		flag off <clubs>
	}
end define
define selection <safecontents>
	info <Do you wish to take the contents of the safe?>
	choice <Yes> {
		msg <You look inside the safe. You retrieve a blank DVD ROM disc.>
		show <DVD-ROM>
		give <DVD-ROM>
	}
	choice <No> msg <You do not look inside the safe.>
end define
define selection <takedeadbattery>
	info <Do you wish to remove the flat battery?>
	choice <Yes> {
		msg <You unclip the large industrial battery from the crane arm.>
		show <DeadBattery>
		give <DeadBattery>
		hide <Crane Arm>
		show <Crane Arm2>
	}
	choice <No> msg <You leave the battery where it is.>
end define
define selection <Do you wish to pick up the metal container with the crane?>
	info <Do you wish to activate the crane?>
	choice <Yes> if flag <shutters> then {
		msg <You activate the crane arm and use the controls to swing it around into the Delivery Bay. You attempt to grab hold of the metal container and get a slightly lop-sided grip on it. You then swing the container back out into the courtyard. The arm is a little over-responsive and you push the right control too far. The steel container crashes into the wall of the entrance hall, knocking bricks and plaster flying. Before you can stop it, the container slides out of the arm's grip, falls over onto the inside wall of the entrance hall and smashes a hole in the ceiling. You gingerly step away from the controls.>
		hide <Crane Arm3>
		show <Crane Arm4>
		hide <Container>
		show <Container2>
	}
	else msg <You activate the crane. You can move the arm about but there does not appear to be anything here to pick up.>
	choice <No> msg <You leave the crane arm alone.>
end define
define selection <climbroof>
	info <Do you wish to climb up the container to the roof?>
	choice <Yes> {
		msg <You clamber up the sides of the metal container and out onto the roof.>
		goto <Roof>
		create exit up <entrance hall; Roof>
	}
	choice <No> msg <You stay in the demolished entrance hall.>
end define
define selection <downladder>
	info <Do you wish to climb down the ladder?>
	choice <Yes> {
		goto <OutsideLab>
		msg <You gingerly hold onto the rusty hand rails and climb down the ladder to the ground.>
	}
	choice <No> msg <You remain on the rooftop.>
end define
define selection <upladder>
	info <Do you wish to climb up the ladder?>
	choice <Yes> {
		goto <Roof2>
		msg <You carefully ascend the ladder to the roof of the corporation's building.>
	}
	choice <No> msg <You stay on the ground.>
end define
define selection <motorbikekey>
	info <Do you wish to take the key from the locker?>
	choice <Yes> {
		msg <You pick up the small key and pocket it.>
		show <Key>
		give <Key>
		hide <Security Locker2>
		show <Security Locker3>
	}
	choice <No> msg <You leave the key where it is.>
end define
define selection <takecandle>
	info <Do you wish to take the candle from the cupboard?>
	choice <Yes> {
		msg <You pick up the candle.>
		show <Candle>
		give <Candle>
		hide <Cupboard>
		show <Cupboard2>
	}
	choice <No> msg <You leave the candle where it is and close the cupboard door.>
end define
define selection <turnwateron>
	info <Do you wish to turn the tap on?>
	choice <Yes> {
		msg <You turn the tap on and water flows out of it and down the plughole.>
		hide <Sink>
		show <Sink2>
	}
	choice <No> msg <You leave the tap turned off.>
end define
define selection <turnwateroff>
	info <Do you wish to turn the tap off?>
	choice <Yes> {
		msg <You turn the tap off and water stops running.>
		hide <Sink2>
		show <Sink>
	}
	choice <No> msg <You leave the water running.>
end define
define selection <unclequestion1>
	info <Will you bring down the corporation?>
	choice <Yes> {
		msg <Your uncle smiles, relieved.|n|n'Thank you, my child. Now go, leave this place, and do your utmost to bring the corporation to justice and avenge me.'|n|nYou smile as your uncle fades into nothing.>
		hide <Uncle>
		hide <Uncle2>
		create exit west <DreamHall; Light>
	}
	choice <No> {
		msg <Your uncle's expression turns sad.|n|n'You are the only one who can help me. If you will not, then I will never be at peace.>
		hide <Uncle>
		show <Uncle2>
	}
end define
define selection <magnetic encoding>
	info <What do you wish to do?>
	choice <Create a New Security Clearance> {
		msg <You select the option to create a new Security clearance of the highest level. The machine buzzes and whirrs and eventually ejects the magnetic encoder, having written the security data to it.>
		hide <Security Computer>
		show <Security Computer2>
		hide <Magnetic Encoder>
		show <Magnetic Encoder2>
		give <Magnetic Encoder2>
	}
	choice <Load An Existing Security Clearance> msg <The computer brings up a message - 'Error: There are no security clearances on file at this time.'>
	choice <Eject Magnetic Encoder> msg <You select the Eject option and the magnetic encoder whirrs out of the burner intact.>
end define

