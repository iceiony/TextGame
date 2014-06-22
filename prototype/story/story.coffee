col = require('./characters').colourFormat

story = {
    intro: ->
        @text """
        Crime scene investigation
        Location : Middle of an empty field in the early hours of Sunday morning. 
        
        Officer in charge :This is an odd one Henry, think we need to call... you know whom.
        Henry : You mean, THAT guy.
        Stevey: Oh ! Surely not that oddball. What are we getting him for ?!
        Chief : Well he's odd alright. But still, oddly better than the lot of us put together.
        Henry : I'll give him a call chief. 
        (Steveey's expression changes to disapproval while he shakes his head)
        
        [.........1 hour later.........]
        
        Far in the distance you can see a car stopping, an old mustang, a muscle car. 
        Driver steps out and heads slowly towards the group of policeman . 
        Behind the chief are the 2 assisting officers, sitting next to each other
        Chief: Detective Wildcard! Glad to see you son.
        
        With some disbelief Stevey leans towards Henry and wispers.
        Stevey : Is this the guy ?
        Henry  : Yep...
        Stevey : He doesn't seem all that.
        Henry  : Yep... 
        Stevey : So his name IS Wildcard!
        Henry  : Yep... 
        Stevey : That's a bit odd isn't it.
        Henry  : Yep... 
        
        Chief : Thanks for doing us the favour and coming down. This is an odd one and we kind of hit a wall here. 
                Can't figure it out , that's why we need your help Willy, to solve this case.
        Stevey: Hrhrhrhaharrr! ; swallowing his laughter 
        
        Chief turns around with a criticising look. 
        He then leans towards Willy and says, #{col.Chief "Don't mind the rookie. He's a good kid" }
        
        Chief : So Detective! ; the chief says in a louder voice while corner eyeing the two officers behind him. 
                We'll provide what ever you require. Just let us know what you need to solve this case.
        """

        @observation
            'look around':
                """
                There are 5-6 other people present: the three officers, 2 paramedics and a farmer.
                The farmer is sitting by his tractor, parked a about 20 meters away towards the road.
                Behind the policeman, about 10 meters away you notice the body of a victim. 
                """
            
        @movement
            'go to body': require('./body')
            'go to paramedics': require('./paramedics')
            'go to farmer': require('./farmer').farmer
            'go to tractor': require('./farmer').tractor
            
        @dialogue('chief')
            'hello':
                """
                Wildard : Hello .
                Chief : Oh where are my manners ? 
                        Greetings Wildcard! Excuse me for skiping the introductions son. 
                        I have with me, Henry and Stevey. 
                        You've met Henry before. And Stevey, well he is straight out of the academy.
                """
            'what is the case':
                """
                Wildcard : What is the situation ? 
                The chief turns around and starts walking towards a body, located about 10 meters behind the policeman. 
                Chief : We got the call at 5AM this morning for a body found in the middle of this field.
                        The call was made by Mike Ranch over there, who was working in the vicinity. 
                The chief points towards a farmer sitting next to his tractor.
                Chief : Given the remote location, we arrived at the scene 1 hours later.
                        We weren't able to identify him yet and no reports of a missing person, from nearby towns.
                        Given it is early Sunday, none of us want to really be here. 
                        So I was hoping you may be able to solve this fast. 
                """
            'witnesses':
                """
                Wildcard : Any witnesses ?
                Chief looks towards a nearby tractor. The tractor driver resting against it. 
                Chief : Mike Ranch over there found the body. We don't have any other weakness besides him.
                """
            'give me a gun':
                """
                Wildcard : Give me a gun !
                Chief squints one of his eyes, in a questioning manner, and asks.  
                Cheif : What do you need a gun for exactly ? 
                Wildcard : I'm a detective, I need a gun .
                Chief : Look son, I don't know if you're being serious or not but we just want you to solve this case not shoot people.
                        I'm not giving you a gun! And I hope you've been taking your medication.
                """
            'what is your name': require('./medication')
               
}
old = ->
    @everywhere ->
        require('./gags')(story)
    @everywhere ->
        "": story.chief_name
        'Look at body / Go to body/ inspect body': ""
        'Paramedics/go to paramedics/talk to paramedics': ""

        'tractor/inspect tractor/examine tractor/go to tractor': ->
        'farmer/go to farmer/talk to farmer': ->
            
        'default': ->
            @text """ Wildcard mutters something indistinguishable """

    chief_name: ->
        @everywhere ->
            require('./medication')(story)
        @everywhere ->
            "yes": ->
                @text """
                
                """
            "no": ->
                @text """
                
                """
                @everywhere ->
                    "chief's name/what is your name chief": ->
                        @text """
            Chief : Willy, take your medication please .
            """
    ending: ->
        @text """
            Willy : He fell from the sky . 
            The officers seem puzeled .
            Chief : What gives you that crazy idea ? 
            Willy : The deep imprint on the ground. The broken bones. The fact that there are no signs of the body being dragged here.
            Henry : What about if he was carried here ?
            Willy : Given the earth is this soft after the rain last night.I would expect to see some deep foot print around .
                    But there is nothing.
            Stevey : Actually , I know there was this large festival yesterday a few towns away. 
                     They had balloon flights too. Maybe there was some trouble form the storm last night. 
            Chief : Alright Willy , I think we know what we have to do now . Henry , get in contact with that festival .
                    Thanks for your help detective. Think you've cracked this .

            [The End]
            """
    exit: ->
        process.exit()

    death: ->
        @text """
        The chief stares at the detective's body in dread
        Chief : "Wildcard's dead ..."
        [Type respawn to start from begining]
        """
        @everywhere ->
            'restart/respawn/start/new': story.intro
            'default': story.death


module.exports = story