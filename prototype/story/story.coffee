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
    @general -> require('./gags')(story) 
    @general ->
      'Look around/Examine surroundings': ->
        @text """
        There are 5-6 other people present: the three officers, 2 paramedics and a farmer. His tractor is parked a about 20 meters away towards the road.
        Behind the policeman, about 10 meters away you notice the body of the victim. 
        """
      "What's the situation? / What am I seeing / Details /Situation / what is going on / what have we got / where is the body / so / what happened ": ->
        @text """
        The chief turns around and starts walking towards a body, located about 10 meters behind the policeman. 
        Chief : "We got the call at 5AM this morning for a body found in the middle of the field."
            "The call was made by Mike Rachid over there, who was plowing in the vicinity." The chief points towards a farmer sitting next to his tractor."
            "Given the remote location, we arrived at the scene 1 hours later. [Body is faced up, a middle aged white male, maybe 45, half naked.] "
            "We weren't able to identify him yet and no reports of missing people from nearby towns."
        """
      'look at the tractor / the tractor': ->
        @text """
        The detective walks to the the front of the tractor. The back of it seems seems geared up with a plow to prepared the earth for seeding. They seem to be in use. 
        You touch the tractor's motor to see if it has been in use recently. But it feels cold to the touch.
        """
      'Paramedics/ go to paramedics': ->
        @text """
        Willy walks to the 2 paramedics resting next to their equipment. 1 Male and one female. 
        They don't look particularly enthusiastic and don't actually notice the detective approaching.
        """
      'farmer / go to farmer' : ->
        @text """
        Willy walks to the farmer. Middle aged man, looks hard working. He was sitting on the ground but stands up as the detective approaches .
        """
      'Body / Look at body / Go to body': ->
        @text """
        Willy walks past the officers and approaches the body. The 2-3 follow his lead. 
        Chief : "That's how we found him. The medical personnel haven't turned him over yet."
                "But they could tell that most of his bones are broken and he's bruised completely on the back where he contacts the earth."
        Henry : "It seems like he literately smashed into the ground." 
        As they get next to the body willy knees next to it and examines in detail. Body is faced up, a middle aged white male, maybe 45, half naked. 
        His right fist seems to be closed in a tight grip.
        """
        @action ->
          'Open fist / Look at fist / fist': ->
            @text """
            Wildcard : Can I touch him ? 
            Chief    : Go ahead Willy. We"ve already collected the evidence needed so far.
            Willy opens the fist of the man without much effort. It wasn't very stiff. Seems he was holding half a match, unused. Wildcard picks up the match staring at it curiously.
            The detective next to him : "What do you think that means willy ?"
            """
          'That he was a smoker / smoking / smoke': ->
            @text """
            Henry: But why only half a match ? And why was it not used.
            """
          "Don't know / silence / white space": ->
            @text """
            The 3-4 sit in silence for a few moments. 
            Stevey:      "What if he was a smoker" 
            Henry :      "But why only half a match ? And why was it not used."
            """
      'witness / witnesses ': ->
        @text """
        Chief looks towards a nearby tractor. The tractor driver resting against it. 
        Chief: "Mike Rachid over there found the body. We don't have any weaknesses."
        """
      'Where did it come from / how did it get here': ->
        @text """
        Henry: "We don't know . We're far in the middle of nowhere here. The body could have come from anywhere."
        """
      'default': ->
        @text """ Wildcard mutters something indistinguishable """
  death: ->
    @text """
    The chief stares at the detective's body in dred
    Chief : "Wildcard's dead ..."
    (Type respawn to start from begining)
    """
    @actions ->
      'restart/respawn/start/new': story.intro
      'default': story.death
}

module.exports = story