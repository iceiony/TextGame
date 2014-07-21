end_game = require './end_game'

module.exports = ->
    @text """
    Willy walks past the officers and approaches the body. They follow his lead. 
    Chief : That's how we found him. The medical personnel inspected him briefly.
    Henry : They said some of his bones are broken and he has a skull fracture. 
            He is not bruised, and just has a few lesions.
    Stevey : You know what's weird, there is just no blood around. Like at all.
    
    As they get next to the body Willy kneels next to it to examine. The earth feels slightly humid because of the storm last night.
    
    Body is faced up, a middle aged white male, maybe 45 and 90kq, half naked. 
    His right fist seems to be closed in a tight grip. Willy could feel a faint smell of alcohol from that distance.
    """

    @observation 
        'look around' : """
        There are 5-6 other people present: the three officers, 2 paramedics and a farmer.
        The farmer is sitting by his tractor, parked a about 20 meters away towards the road.   
        And also... there is the body .
        """
    
        'look at body' : """
        Willy looks around . 
        
        No blood and no tracks to indicate that the body may have been dragged to that location.  
        There is a single set of footprints that clearly do not belong to the authorities. 
        """
        
        'search body' : """
        The detective attempts to search the victim. 
        There is not much to search through, given the victim is not wearing a shirt. 
        He puts his hands through the trousers pockets but can't find anything. 
        
        Henry : We've searched him as well. We couldn't find anything. 
        """
        
        'look at mouth' : """
        The detective opens the victim's mouth. There is nothing special except for a more obvious smell of alcohol and death
        """
        
        'look at nails' : """
        The detective looks at the nails. They are clean and well cut. 
        """
        
        'look at fist' : """
        Wildcard looks at the man's fist. It is in a tight grip.
        """
        
        'check pulse' : """
        The detective checks the victim's pulse. He's deffinitely dead.
        Stevey wispers to Henry.
        Stevey : "Why is this wierdo checking the pulse". 
        """
        
    @action 
        'touch body' : """
        Wildcard touches the body. He doesn't seem to be looking for anything in particular though.
        It feels cold to the touch.
        """
        
        'poke body' : """
        Wildcard pokes the body. It doesn't move. The guy is clearly not going anywhere. What was Wildcard thinking ?   
        """
    
    @dialogue('chief')
        'ask about footprints':"""
        Willy : What are those footprints ? 
        Chief : We've identified those as belonging to Mark, the farmer who found the body. 
        Willy looks at the tracks, they seem no different from those made by the officers. Nothing significant about them though. 
        """

        'any id' : """
        Wildcard : Any Id?
        Henry : No. Nothing.   
        """
        
        'how did it get here' : """
        Henry: "We don't know . We're far in the middle of nowhere here. The body could have come from anywhere."
        Chief: "That's why we called you detective"
        """
        
        'fell from the sky' : ->
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
            """
            end_game.solveEnding("accident")
            @text end_game.getEndingStatus()

    @action 
        'turn over' : """
        Wildcard : I'll turn him over if that is ok .
        Chief    : Sure, go right ahead. 
        
        As he attempts to turn the body to the side, he notices the imprint on the ground. 
        The body, altough simingly lying straight, was buried about 4cm in debth.  
        The shape of the imprint had the features of the body itself.
    
        Wildcard rolls him to the side and pushes him all the way through. He notices how sludgy the body feels and how 
        most of the bone anatomy doesn't feel right . 
        
        There is nothing else special about the back of the body.
        """
        
        'open fist' : ->
            @text """
            Wildcard : Can I touch him ? 
            Chief    : Go ahead Willy. We've already collected the evidence need so far.
        
            Willy opens the fist of the man without much effort. It wasn't very stiff. Seems he was holding a short match, unused.
            The detective picks up the match staring at it curiously.
            The match seems to have been broken in two, and now only the top half could be found. 
        
            Henry    : What do you think that means Willy ?
            """
            @dialogue('henry')
                'he was a smoker' : """
                Wildcard : He smokes. 
                Stevey : But why only half a match ? And why was it not used.
                """
                
                'do not know' : ->
                    @text """
                    The group sits in silence for a few moments. 
                    Henry : What if he was a smoker ?
                    """
                    @dialogue('chief')
                        'do not know': " Willy is within his own thoughts... He does not say a thing."
        
        'take match' : -> 
            @text """
            Chief: "Sorry Willy you can't have that. We have to use it for evidence, what ever it is."
            The chief pulls out a small plastic bag from his poket. He opens it and performs a gesture requesting Wildcard to place in, the match.
            """
            @action 
                'use match' : """
                Ignoring the Chief's request, Wildcard calmly checks his own pockets in search for something. 
                The let one, the right one on his coat, both are empty. Ahh the inner pocket, he pulls out a cigar.
                While completely avoiding eye contact with the Chief's intensive stare, he ligts the match on the side of his shoe and proceeds to light his cigar.
                He throws the used match to the side. He takes one puff with a statisfying grin on his face while staring at the cigar and noding slowly. 
                
                The chief puts the plastic bag back in his pocket. He is clearly not happy, and stares at Wildcard in a frightening manner.
                He doesn't say a word though.

                [ *** Achievement : You are the wildcard ! *** ]
                """
                
                'give match' : """
                Willy puts the match into the bag. 
                The chief thanks him, seals the bag and hands it to Henry.  
                """
                
                'take match/keep match' : """
                Ignorign the chief's request Wildcard puts the match in his pocket. 
                Chief : What are you doing ? [ with a slight frustration in his voice ]
                Willy : I need it...
                Chief : For what ? 
                Willy : Something...
                Chief shakes his head in dissagrement while placing the bag back in the pocket. 
                He trusts Willy enough to follow his methods to the end.
                
                [ Wildcard has acquired an unused match ]                    
                """
            
            @dialogue('chief')
                '' : "Chief : Come on Willy put it in."