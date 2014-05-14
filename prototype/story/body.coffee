loc = require './locations'

module.exports = (story) ->
  ->
    @location loc.next_to_body
    @text """
    Willy walks past the officers and approaches the body. They follow his lead. 
    Chief : That's how we found him. The medical personnel inspected him briefly
    Henry : They said some of his bones are broken and he has a skull fracture. 
            He is not bruised, and just has a few leasions.
    """
    if(not @steveyLeft )
      @text "Stevey : You know what's weird, there is just no blood around. Like at all."

    @text """
    As they get next to the body Willy kneels next to it to examine. The earth feels slightly humid because of the storm last night.
    
    Body is faced up, a middle aged white male, maybe 45 and 90kq, half naked. 
    His right fist seems to be closed in a tight grip. Willy could feel a faint smell of alcohol from that distance. 
    """
    @everywhere ->
      "he fell from the sky/he fell from large height / he fell from height/he fell from balloon / he fell from plane" : story.ending
    
    @location loc.next_to_body, ->
      'tracks/footprint/look around the body/look around' :->
        @text """
        Willy looks around . No blood , no tracks indicating the body may have been dragged all the way there. 
        There is only one set of footprints that are clearly indicated as belonging to the police.  
        """
        @location loc.next_to_body, ->
          "ask about footprints/ check footprints/who do those footprints belong to/look at footprints/check footprints" :->
            @text """
            Willy : What are those footprints ? 
            Chief : We've identified those as belonging to Mike, the farmer who found the body. 
            Willy looks at the tracks, they seem no different from those made by the officers. Nothing significant about them . 
            """
      'open mouth/check nails' : ->
        @text """The detective opens the victim's motth. There is nothing special except for a more obvious smell of alcohol and death """
      'check nails/look at nails' : ->
        @text """The detective looks at the nails. They are clean and well cut. """ 
      'check pulse/verify pulse/take pulse': ->
        @text """The detective checks the victim's pulse. He's deffinitely dead. """
        if not @steveyLeft 
          @text """Stevey wispers to Henry, "Why is this wierdo checking his pulse". """ 
      'touch': ->
        @text """
        Wildcard touches the body. He doesn't seem to be looking for anything particular though.
        It feels cold to the touch.
        """
      'poke': ->
        @text """
        Wildcard pokes the body. It doesn't move. The guy is clearly not going anywhere. What was Wildcard thinking ?   
        """
      'Where did it come from / how did it get here': ->
        @text """
        Henry: "We don't know . We're far in the middle of nowhere here. The body could have come from anywhere."
        Chief: "That's why we called you detective"
        """
      'turn over': ->
        @text """
        Wildcard : I'll turn him over if that is ok .
        Chief    : Sure, go right ahead. 
        
        As he attempts to turn the body to the side, he notices the imprint on the ground. 
        The body, altough simingly lying straight, was buried about 4cm in debth.  
        The shape of the imprint had the features of the body itself.

        Wildcard rolls him to the side and pushes him all the way through. He notices how sludgy the body feels and how 
        most of the bone anatomy doesn't feel right . 
        
        There is nothing else special about the back of the body.
        """
            
      'Open fist / Look at fist / fist/ examine fist/insepct fist': ->
        @text """
        Wildcard : Can I touch him ? 
        Chief    : Go ahead Willy. We"ve already collected the evidence need so far.

        Willy opens the fist of the man without much effort. It wasn't very stiff. Seems he was holding a short match, unused.
        The detective picks up the match staring at it curiously.
        The match seems to have been broken in two, and now only the top half could be found. 

        Henry    : What do you think that means Willy ?
        """
        @location loc.next_to_body, ->
          'Take match/put in pocket': ->
            @location loc.open_bag
            @text """
            Chief: "Sorry Willy you can't have that. We have to use it for evidence, what ever it is."
            The chief pulls out a small plastic bag from his poket. He opens it and performs a gesture requesting Wildcard to place in, the match.
            """
            @location loc.open_bag, ->
              'light match/use match': ->
                @location loc.next_to_body
                @text """
                Ignoring the Chief's request, Wildcard calmly checks his own pockets in search for something. 
                The let one, the right one on his coat, both are empty. Ahh the inner pocket, he pulls out a cigar.
                While completely avoiding eye contact with the Chief's intensive stare, he ligts the match on the side of his shoe and proceeds to light his cigar.
                He throws the used match to the side. He takes one puff with a statisfying grin on his face while staring at the cigar and noding slowly. 
                
                The chief puts the plastic bag back in his pocket. He is clearly not happy, and stares at Wildcard in a frightening manner.
                He doesn't say a word though.
                """
                @chiefIsAngry = true
                
              'give match/yes/put in bag': ->
                @location loc.next_to_body
                @text """
                Willy puts the match into the bag. 
                The chief thanks him, seals the bag and hands it to Henry.  
                """
                
              'no/keep match/take match/put in pocket': ->
                @location loc.next_to_body
                @text """
                Ignorign the chief's request Wildcard puts the match in his pocket. 
                Chief : What are you doing ? [ with a slight frustration in his voice ]
                Willy : I need it...
                Chief : For what ? 
                Willy : Something...
                Chief shakes his head in dissagrement while placing the bag back in the pocket. 
                He trusts Willy enough to follow his methods to the end.
                
                [....Willy has acquired an unused match....]                    
                
                """
                @hasMatch = true
                
              '': ->
                @location loc.open_bag
                @text """Chief : Come on Willy put it in."""
                
              'ignore': ->
                @location loc.open_bag
                @text """Chief : Come on Willy put it in."""
                
          'That he was a smoker / smoking / smoke': ->
            @text """
            Henry: But why only half a match ? And why was it not used.
            """
          "Don't know / nothing /shut up/": ->
            @text """
            The group sits in silence for a few moments. 
            Henry : What if he was a smoker ?
            """
            
            if(not @steveyLeft)
              @text """Stevey : But why only half a match ? And why was it not used. """
            
            @location loc.next_to_body, ->
               "Don't know / nothing /shut up/": -> 
                 @text """
                 Willy is within his own thoughts... He does not say a thing.
                 """