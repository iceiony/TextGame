story = {
  intro: ->
    @text """
    Crime scene investigation
    Location : Middle of an empty field . Early hours of Monday morning. 
    
    Officer in charge : "this is an odd one Henry, think we need to call you know you."
    Henry :             "You mean, THAT guy."
    Stevey:             "Oh ! Surely not that oddball. What are you getting him for ?!"
    Chief :             "Well he's odd alright. But still oddly better than the lot of us put together."
    Henry :             "I'll give him a call chief." 
    (Steveey's expression changes to disapproval)
    
    --1 hour later--
    Far in the distance you can see a car stop, old mustang, a muscle car. Driver steps out , head slowly towards the group of policeman . 
    Behind the chief are the 2 assisting officers, sitting next to each other
     Chief: "Detective Wildcard, glad to see you son"
    (Stevey with some disbelief leans towards Henry.
    (Stevey " Is this the guy ?")
    (Henry  "Yep.")
    (Stevey "he doesn't seem all that" )
    (Henry  "Yep")
    (Stevey "So he's name IS Wildcard" )
    (Henry  "Yep")
    (Stevey "That's a bit odd isn't it")
    (Henry  "Yep")
    
    Cheif: "Thanks for doing us the favour and coming down. This is an odd one and we kind of hit a wall here. Can't figure it out , that's why we need your help Willy." 
    (Stevey: "Hrhrhrhaharrr!" , swalowing his laughter ) 
    (Chief turns around with a criticising look. He then leans towards Willy and says : "Don't mind the rookie. He's a good kid" ) 
    Chief: "So Detective!" the chief says in a lewder voice while corner eyeing the two officers behind him. 
           "We'll provide what ever you require. Just let us know what you need to solve this case."
    """
    @general ->
      'Cigar/Fag/Smoke': ->
        @clearGeneral()
        @text """ 
        With a content look on his face, Willy starts to collect his thoughts. He reaches to the inside of his jacket and pulls out a cartridge of cigars and a lighter. 
        He takes one puff and looks satisfied. As he seems to about to say something he starts coughing violently and falls to the ground.
        Paramedics at the scene of the crime rush to save him. They conclude it's cancer and fail to save the detective. He dies within a few minutes. 
        Henry : "Such a shame" shaking his head in denial. 
        Chief : "This is what you get when smoking. Rest in peace Wildcard."
        (Type respawn to start from begining)
        """
        @actions ->
          'respawn/restart': story.intro
          'default': story.death
      '': ->
        @text """
        Wildcard seems like he's about to say something. He raises his hand in a gesture which seems that he's about to make a point. 
        But tilts his head in a matter of confusion.
        The chief looks at him patiently. 
        """
        @general ->
          '': ->
            @text """
              Wildcard sits in silence. He doesn't look like he's about to say or do anything. 
              Chief gains a crious look in his eyes : "Willy ?"
              """
            @general ->
              '': ->
                @text """
                5 minutes pass. Everyone is frozen still waiting for Wildcard to take action.
                Chief : Com on detective, say something! What's the matter?
                Chief gazez over to the paramedics with a thought to call them over. They notice his gaze and set up as if ready to answer the urgent call. 
                """
                @general ->
                  '': ->
                    @clearGeneral()
                    @text """
                    From behind the Chief, Stevey pulls a gun. In a blink of an eye, he shoves the Chief aside points the gun at Wildcard and pulls the trigger.
                    Wildcard falls to the ground . Henry and the Chief jump on Stevey to dissarm him. 
                    The paramedics nearby rush to save him. But he's dead, shot through the hart.
                    """
                    @actions ->
                      'default': story.death
      'coffee': ->
        @text """
          Chief : "Coffee ?" A bit of a confused look could be noticed on the chief's face. 
          Chief : Stevey , you heard the man, get him a coffee . 
          Stevey: Coffe ? But we're in the middle of nowhere, where the heck am I going to get coffee here. The nearest town is an hour away.
                  Chief turns around with an angry look in his eyes. Stevey suddenly realises his mischief. 
          Stevey: Yes sir , chief. On my way!  As he starts rushing to the cars in the distance. 
          Cheif turns back to the detective: "Well that will probably take him a while . Shall we continue meanwhile ?" """
        @general ->
          'coffee': ->
            @text """Chief : "Stevey on the way to get you one Willy. Can we please focus on the crime scene for now ." """
            @general -> 
              'coffee': -> 
                @text """Cheif: Look I know it's quite an early Sunday morning, but we all want to finish this and go home. """
                @general ->
                  'coffee': ->
                    @text """
                    Chief looks a bit irritated now.
                    Chief:"Look Willy, I know you have your issues. But we quite need your head on this case. Now please focus for a moment."
                          "We're in the middle of nowhere early Sunday morning, we want to finish this fast" """
                    @general -> 
                      'coffee': ->
                        @text """Chief acts as if he doesn't even hears the the word. Stares Willy dead cold in the eyes """
                        @general ->
                          'coffee': ->
                            @text """
                            Willy leans to his bag next, reaches in and pulls out a coffee cup. He extends his hand to give it to the chief.
                            He looks straight back into the Chief's eyes and repeats.
                            Willy: "Coffee"
                            The chief hesitantly takes the coffee, his concerned eyes shifting between the cup end Wildcard's serious stare.
                            Chief: " Thanks... " he says with some hesitance in the voice

                            Willy proceeds to give pull out more cups for the people around . 
                            He hands one to Henry, another two to the paramedics and one last one to the farmer sitting next to his parked tractor.""" 
                            @general ->
                                'coffee' : ->
                                  @text """
                                       Chief: "Yes, thanks for the coffee Willy, it was an...unexpected treat "
                                       As he raises his coffee cup in appreciation  he looks around as the surrounding party approves."""
      'default': ->
        @text """ Wildcard mutters something indistinguishable """
  death: ->
    @text """
    The chief stares at the detective's body in dred
    Chief : "Wildcard's dead ..."
    (Type respawn to start from begining)
    """
    @actions ->
      'restart/respawn': story.intro
      'default': story.death
}

module.exports = story

#
##->"Ciggar"/"Ciggaret"

#  
##-> Punch
##-> google
##-> phone

#                              
##-> Look around / Look / Examine
#    """There are 5-6 other people present: the three officers, 2 paramedics and a farmer. His tractor is parked a about 20 meters away towards the road.
#    Behind the policeman, about 10 meters away you notice the body of the victim.""" 
##    -> look at the tractor / the tractor 
#        """The detective heads twards the front of the tractor. The back of it seems seems geared up with a plow to prepared the earth for seeding. They seem to be in use. 
#        You touch the tractor's motor to see if it has been in use recently. But it feels cold to the touch."""  
##    <- Return
#        """Willy returns to the group of people near the crime scene"""
##    -> Paramedics
#        """Willy walks to the 2 paramedics resting next to their equipment. 1 Male and one female. 
#           They don't look particularly enthusiastic and don't actually notice the detective approaching.""" 
##    -> Farmer 
#        """Willy walks to the farmer. Middle aged man, looks hard working. He was sitting on the ground but stands up as the detective approaches ."""
##    -> Body / Look at body / Go to body 
#        """Willy walks past the officers and approaches the body. The 2-3 follow his lead. 
#        Chief : "That's how we found him. The medical personnel haven't turned him over yet."
#                "But they could tell that most of his bones are broken and he's bruised completely on the back where he contacts the earth."
#        Henry : "It seems like he literately smashed into the ground." 
#        As they get next to the body willy knees next to it and examines in detail. Body is faced up, a middle aged white male, maybe 45, half naked. 
#        His right fist seems to be closed in a tight grip."""
##        -> Open fist / Look at fist
#            """Wildcard : Can I touch him ? 
#            Chief    : Go ahead Willy. We"ve already collected the evidence needed so far.
#            Willy opens the fist of the man without much effort. It wasn't very stiff. Seems he was holding half a match, unused. Wildcard picks up the match staring at it curiously.
#            The detective next to him : "What do you think that means willy ?" """ 
##            -> That he was a smoker / smoking
#                """Henry: But why only half a match ? And why was it not used.""" 
##            -> Don't know / silence / white space
#                """The 3-4 sit in silence for a few moments. 
#                Stevey says : "What if he was a smoker" 
#                Henry :  But why only half a match ? And why was it not used."""
##        -> When was he found ? 
##    
##-> "What's the situation?" / "What am I seeing" / Details /Situation / what is going on / what have we got / where is the body / so /
#    """The chief turns around and starts walking towards a body, located about 10 meters behind the policeman. 
#    Chief : "We got the call at 5AM this morning for a body found in the middle of the field."
#            "The call was made by Mike Rachid over there, who was plowing in the vicinity." The chief points towards a farmer sitting next to his tractor."
#            "Given the remote location, we arrived at the scene 1 hours later. [Body is faced up, a middle aged white male, maybe 45, half naked.] "
#            "We weren't able to identify him yet and no reports of missing people from nearby towns." """
##-> Look at time / watch 
#    """Willy looks at his wrist watch. It shows 9:07AM.""" 
##-> witness / witnesses 
#    """Chief looks towards a nearby tractor. The tractor driver resting against it. 
#    Chief: "Mike Rachid over there found the body. We don't have any weaknesses.""" 
##    -> Where did it come from ? 
#        """Henry "We don't know . We're far in the middle of nowhere here. The body could have come from anywhere." """
##-> tractor driver / farmer
##-> paramedics 
##-> N/A  ( anything that is not in the list ) 
##    -> 