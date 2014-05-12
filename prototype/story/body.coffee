next_to_body = "next to body"
open_bag = "open bag"

module.exports = (story) ->
  ->
    @location next_to_body
    @text """
    Willy walks past the officers and approaches the body. The 2-3 follow his lead. 
    Chief : That's how we found him. The medical personnel inspected him briefly
    Henry : They said some of his bones are broken and he has a skull fracture. 
            He doesn't have any bruises but just a few leasions .
    """
    if(not @steveyLeft )
      @text "Stevey : You know what's weird, there is just no blood around. Like at all."

    @text """
    As they get next to the body Willy kneels next to it to examine. Body is faced up, a middle aged white male, maybe 45, half naked. 
    His right fist seems to be closed in a tight grip.
    """
    
    @location next_to_body, ->
      'touch': ->
        @text """
        Wildcard touches the body. He doesn't seem to be looking for anything particular though.
        It feels cold to the touch.
        """
      'poke': ->
        @text """
        Wildcard pokes the body. It doesn't move. The guy is clearly not going to move. What was Wildcard thinking ?   
        """
      'Where did it come from / how did it get here': ->
        @text """
        Henry: "We don't know . We're far in the middle of nowhere here. The body could have come from anywhere."
        Chief: "That's why we called you detective"
        """
      'Open fist / Look at fist / fist/ examine fist/insepct fist': ->
        @text """
        Wildcard : Can I touch him ? 
        Chief    : Go ahead Willy. We"ve already collected the evidence needed so far.
        Willy opens the fist of the man without much effort. It wasn't very stiff. Seems he was holding a short match, unused.
        The detective picks up the match staring at it curiously.
        The match seems to have been broken in two, and now only the top half could be found. 
        Henry    : What do you think that means Willy ?
        """
        @location next_to_body, ->
          'Take match/put in pocket': ->
            @location open_bag
            @text """
            Chief: "Sorry Willy you can't have that. We have to use it for evidence, what ever it is"
            The chief pulls out a small plastic bag from his poket. He opens it and performs a gesture requesting Wildcard to place in, the match.
            """
            @location open_bag, ->
              'light match/use match': ->
                @location next_to_body
                @text """
                Ignoring the Chief's request, Wildcard calmly checks his own pockets in search for something. 
                The let one, the right one on his coat, both are empty. Ahh the inner pocket, he pulls out a cigar.
                While completely avoiding contact with the Chief's intensive stare, he ligts the match on the side of his shoe and proceeds to light his cigar.
                He takes one puff with a statisfying grin on his face, and throws the used match to the side. 
                
                The chief puts the plastic bag back in his pocket. He is clearly not happy, and stares at Wildcard in a frightening manner.
                He doesn't say a thing though.
                """
                @chiefIsAngry = true
                
              'give match/yes/put in bag': ->
                @location next_to_body
                @text """
                Willy puts the match into the bag. 
                The chief thanks him, seals the bag and hands it to Henry.  
                """
                
              'no/keep match/take match/put in pocket': ->
                @location next_to_body
                @text """
                Ignorign the chief's request Wildcard puts the match in his pocket. 
                Chief : What are you doing ? [ with a sorth of frustrated tone in his voice ]
                Willy : I need it...
                Chief : For what ? 
                Willy : Something...
                Chief shakes his head in dissagrement while placing the bag in his pocket. 
                He trusts Willy enough to follow his methods to the end.
                [....Willy has acquired a match....]                    
                """
                @hasMatch = true
                
              '': ->
                @location open_bag
                @text """Chief : Come on Willy put it here."""
                
              'ignore': ->
                @location open_bag
                @text """Chief : Come on Willy put it here."""
                
          'That he was a smoker / smoking / smoke': ->
            @text """
            Henry: But why only half a match ? And why was it not used.
            """
          "Don't know / nothing /shut up/": ->
            @text """
            The 3-4 sit in silence for a few moments. 
            Henry : What if he was a smoker ?
            """
            
            if(not @steveyLeft)
              @text """Stevey : But why only half a match ? And why was it not used. """
            
            @location next_to_body, ->
               "Don't know / nothing /shut up/": -> 
                 @text """
                 Willy seems to be within his own thoughts...
                 """