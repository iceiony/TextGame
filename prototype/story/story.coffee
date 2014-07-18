col = require('./characters').colourFormat

story = {
    intro: ->
        @text """
        Crime scene investigation
        In the middle of an empty field in the early hours of Sunday morning. Three policement discuss a most peculiar case. 
        
        Chief : This sure is an odd one Henry. 
        Henry : Sure is cheif. 
        Chief : I think, to crack this one, we might need to call some special help .
        Henry : Do you mean, call THAT guy?
        Stevey: Oh ! Surely not that oddball. What the heck are we getting him for ? 
        Chief : He's odd alright. But oddly he's still better than the three of us put togheter. 
                Besides Stevey, you've never met him before, so what are complaining about. 
        Stevey: Hmph! I've heared plenty of stories. ( he says in dissaproval )
        Henry : Alright, I'll give him a call chief. 
        
        [press 'enter' to continue]
        """
        
        @silence ->
            @text """
            [.........1 hour later.........]
            
            Far in the distance a car slows to a stop. An old mustang, a muscle car. 
            Driver steps out and heads slowly towards the group of policeman . 
            Behind the chief are the 2 assisting officers, sitting next to each other.
            Chief: Ah! Detective Wildcard, glad to see you son.
                   How are you ?
            """
        
            @dialogue('chief')
                "i am good": 
                    """
                    Wildcard : Great.
                    Chief : Aham...  
                            Well any how, thanks for doing us the favour and coming down. This is a verry odd case. And we kind of hit a wall here. 
                            That's why we need your help Willy, to solve it or point us in the right direction.
                    Stevey: "Willy", Hrhrhrhaharrr!  ( Stevey chuckles ) 

                    Chief turns around with a criticising look. 
                    He then leans towards Willy and says, #{col.Chief "Don't mind the rookie. He's a good kid" }
                    
                    Chief : So Detective! ( the chief exclaim, while corner eyeing the two officers to his right ) 
                           The crime scene is yours to investigate. We'll answer any questsions we can. 
                    """
                "not so good":
                    """
                    Wildcard : Not so good.
                    Chief : Aham...  
                            Well any how, thanks for doing us the favour and coming down. This is a verry odd case. And we kind of hit a wall here. 
                            That's why we need your help Willy, to solve it or point us in the right direction.
                    Stevey: "Willy", Hrhrhrhaharrr!  ( Stevey chuckles ) 

                    Chief turns around with a criticising look. 
                    He then leans towards Willy and says, #{col.Chief "Don't mind the rookie. He's a good kid" }
                    
                    Chief : So Detective! ( the chief exclaim, while corner eyeing the two officers to his right ) 
                           The crime scene is yours to investigate. We'll answer any questsions we can. 
                    """
                
        @observation
            'look around':
                """
                Wildcard looks around. 
                There are six other people present: the three officers, two paramedics and a farmer.
                The farmer is sitting by his tractor, parked a about 20 meters away towards the road.
                Behind the policeman, about 10 meters away you notice the body of a victim. 
                """
            
        @movement
            'go to body': require('./body')
            'go to paramedics': require('./paramedics')
            'go to farmer': require('./farmer').farmer
            'go to tractor': require('./farmer').tractor
            
        @dialogue('chief')
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
                        So I was hoping you may be able to solve this faster. 
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