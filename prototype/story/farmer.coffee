end_game = require './end_game'

farmer = ->
    @text """
    Willy walks to the farmer. Middle aged man, dirty black hands, with a bit of a red face.
    He was sitting on the ground but stands up as the detective approaches .
    """
    @observation 
        'look at tractor' : tractor
    
    @dialogue('farmer')
        'what is your name': ["""
        Wildcard : What is your name ?
        With a big smile on his face, the farmer wipes his hands on the back of his trousers and extends one to shake the detective's hand. 
        
        Farmer : "Mark Ranch sir , how do you do !" , shaking the detective's hand in an excited manner.             
        """
        """
        Willy : What was your name again ?
        Farmer : Mark Ranch, but people call me Edd.
        """
        """
        Willy : I forgot your name, what was it ? 
        Farmer : Mark Ranch, or Edd. 
        """]
        'who is edd' : """
        Willy : Who is Edd ? 
        Farmer : Why I am sir. People call me Edd .
        """
        "i thought you are Mark/wasn't your name Mark/ your name is Mark": """
        Willy : Wasn't your name Mark?
        Farmer : Yes sir, Mark Ranch .
        Willy : How do you get Edd from Mark  ?
        Farmer doesn't answer. He just laughs in a sly manner. 
        """
        "why are you laughing" : """
        Wildcard: Why are you laughing ? 
        Farmer : Why not, it's not illegal . 
        """
        'hello' : ["""
        Willy  : Greetings !
        Farmer : Good morning sir.
        """
        """
        Willy : Good morning !
        Farmer : Yes good morning !
        """]
        'how do you do': """
        Willy : How do you do ?
        Farmer: I'm ok now. I was a bit shooken up about the findings earlier. But I'm ok now.
        """
        'where are you from' : """
        Detective : Where are you from ?
        Farmer : Oh I live a few miles a way. Near a small town. I'm not exactly in town.
                 I keep to myself ... 
        """
        'what do you do' : """
        Willy : What is it that you do ? 
        Mark  : "I drive this here tractor to plow the land for seeding", he says as he pridefully rests against the tractor.
        
        For some reason , Mark seems a bit tipsy and the detective notices. 
        """
        'why' : ["""
        Willy : Why ?
        Mark  : Why what ?
        """
        """
        Willy : Why ?
        Mark  : Why what ? 
        [.....you can tell this conversation is going places.....]
        """
        ]
        'wtf' : """
        Willy : WTF ?
        While scratching his head with a dumb look on his face the farmer says:
        Farmer : I don't know what you want mister 
        """
        'lol' : """
        Willy laughs histerically : " HaHahAhAhahaha!"
        Marks is not smiling anymore . He now seems a bit scared of the detective's unrequired display.
        """
        'why Sunday/you work Sunday/working sunday/why work today' : """
        Willy : Why you working on a Sunday ?
        Mark's face changes to a serios one. His voice starts trembling . 
        Mark : Because, because... I need to plow this here land . 
        Willy : "Do you usually work on a Sundays?" The detective says squinting his eyes.
        Mark's eyes wide open. He crosses his at his chest and says.
        Mark : "Look here I needed to do my job, right ? So that's why I'm here on a Sunday. You can't arrest me for working Sunday!
               ...Rihtght ?".  He says in a loud slightly agressive manner. 
        As he says that, the detective smells the alcohol filled breath of the farmer. He's been drinking. 
        """
        'did you know him/have you ever seen him before' : """
        Willy : Did you happen to know the victim ? 
        Farmer : Well , when I realised he's dead, I got so frightent that I didn't get a good luck at him.
                 But he didn't look familiar... And I don't get to meet a lot of people so I don't know him.
        """
        'ask about body' :"""
        Willy  : Tell me how you found the body .
        Farmer : I got here about 5AM this morning. Because of the storm last night , the earth is soft so it's easier to work it with the tractor.
                 So I was about 100 meters in from the road when I notice something in the distance. I couldn't tell what it was. 
                 But I stopped the tractor to check it. When I got close I saw the person lying there, not moving.
                 So I thought to myself , this guy is dead. And then I rushed to my tractor , drove to the nearest phone and called the police.
        """
        'ask for more' : """
        Willy : Anything else you can share ?
        Farmer : That's all I know detective. 
        """
        'you have been drinking/drunk driving' : ->
            @text """
            Willy : You've been drinking. I can arrest you for drinking Mark .
                    What are you doing here on a Sunday morning, drunk and driving a tractor ?
            Mark seems scared now, he pleads to Willy and the officers : 
            Mark  : Look I came here to work! Sure I had a bit to drink, but I didn't hurt no body! 
            Willy : What about the body ? How did it get here ? 
            Mark  : "I don't know how it got here !" he says in a loud tone gesticulating with his right hand towards the detective. 
                    Why did I call you fellas in the first place ? 
            
            [....a moment of silence....]
            
            The chief pulls Willy's coat a bit and wispers in his ear ? 
            Chief : What do you think willy? Think he did it  ?
            """
            @dialogue('chief')
                'no': """
                Willy wispers back .
                Willy : No, not yet, but I need to question him more and find out what he was up to.
                """
                'yes': ->
                    @text """
                    Willy : Yes. For sure !
                    Chief : What about the body, why are all the bones broken ? What if he ran the fella over with his tractor ?
                    """
                    @dialogue('chief')
                        'no' : """
                        Willy : I don't think so
                        Chief : Ok Will , I trust your judgement
                        """
                        'yes/hit by tractor' : -> 
                            @text """
                            Willy's sight becomes fixed on Mark.
                            Willy : You know what we think Mark ? We think you hit this poor fellow with your tractor and then you called us.
                            With despayr and a bit of anger Mark responds.
                            Mark  : No... NO ! I didn't run anyone down. I was here to work, I had to finish the job since I couldn't yesterday.
                                    Because the storm hit in the evening and I couldn't work till late! 
                                    "To finish !" , he insists 
                    
                            Chief wispers to Wildcard. 
                            Chief : Do you believe him Willy ? 
                            """
                            @dialogue('chief')
                                'yes/i believe him' : """
                                Willy : I believe him
                                Chief : Well I still don't like that he's drunk driving. I might arrest him just for that .
                                Chief turns to the farmer.
                                Chief : Why are you drunk Edd ? Why did you come here like this ? You know I can arrest you for just that ! 
                                Farmer : Ok , please don't ! You see this place here is empty there's nothing to do. There ain't no one for an 1 distance. 
                                         So I thought, you know , what is the harm?  
                                Chief : Now how do I know you didn't drive here drunk and hit this fellow on the way here ?
                                Farmer : "No ! I didn't, I swear !" ; Mark desperately pleads
                                        I still have the bottle in my tractor over here. 
                                He takes out his key and opens the tractor's cabin. He then pulls from below the seat a bottle of wisky. 
                                """
                                'no' : ->
                                    @text """
                                    Willy : He ran the victim over with the tracor, while drunk .
                                    Chief : I see , I see. We won't know for certain until the autopsy. But ! 
                                    Chief looks at Mark, the farmer .
                                    Chief : Where were you last night ?
                                    Mark  : I was home. 
                                    Chief : Anyone home with you  ?
                                    Mark  : No. I'm all by myself. 
                                    Chief : Ok Henry cuff him . You're under arest Mark.
                                    
                                    Mark : "But I didn't do nothing.", he says and struggles as Henry was puttin on the hand cuffs .
                                    """
                                    end_game.solveEnding("murder")
                                    @text end_game.getEndingStatus()
                                
                'hit by tractor' : ->
                    @text """
                    Willy : He ran the victim over with the tracor, while drunk .
                    Chief : I see , I see. We won't know for certain until the autopsy. But ! 
                    Chief looks at Mark, the farmer .
                    Chief : Where were you last night ?
                    Mark  : I was home. 
                    Chief : Anyone home with you  ?
                    Mark  : No. I'm all by myself. 
                    Chief : Ok Henry cuff him . You're under arest Mark.
                    
                    Mark : "But I didn't do nothing.", he says and struggles as Henry was puttin on the hand cuffs .
                    Chief : We'll let the curt decide that.
                            Ok detective, I think we can handle it from here. Thanks for your help 
                    """
                    end_game.solveEnding("murder")
                    @text end_game.getEndingStatus()

tractor = ->
    @text """
    The detective walks to the the front of the tractor. 
    He leans to one side and observes the back of it is geared up with a plow to prepare the earth for seeding.  
    You touch the tractor's front motor to see if it has been in use recently. But it feels cold to the touch.
    
    The farmer sitting next to it stands up as the detective approaches."""
    @action 
        'talk to farmer' : farmer
    
    @observation 
        'look for key' : "Wildcard wonders who would have the keys"

    @dialogue('farmer')
        'ask farmer for key' : """
        Wildcard : Can I get the key to the tractor ? 
        Farmer : Uhm , sure mister. But what you wanna search in there for ? 
        Wildcard : I have my reasons .
        The farmer reaches into his shirt pocket and pulls out a key which he hands to the detective. 
        [ ....Wildcard has aquired the tractor key.... ] 
        """
        
    @action 
        'drive tractor' : ->
            @text "Wildcard would, but he is missing the key."
            @action 
                'drive tractor' : ->
                    @text """
                    Wildcard uses the tractor key to open the cabin. As soon as he does, he notices a bottle ledged under the seat. 
                    Catching his attention he pulls it out and realises, it is a half empty bottle of wisky. 
                    He opens it, takes a large sip, throws the bottle to the chief and steps up into the tractor's cabin.
                    The chief looks mesmerised and enigmatic at the detective's actions. 
                    As he opens his mouth to speak, Wildcard shuts the door to the cabin, and locks it . 
                    He proceeds to turn on the engine and to press the acceleration peddal. 
                    As he does so, the people around take astep back.
                    The tractor speeds in a straight line towards the paramedics who jump out of it's way. 
                    The tractor keeps heading straight, as if out of controll, barely passing the body with its weels. 
                    Unfortuantely the plowing gear which are wider , hits the body and shreads it to bits. 
                    
                    In the gruesome course of events, Stevey recovers composure and starts runnign after the tractor. 
                    He catches up, jumps against the cabin and shouts as hard as his lungs could take him. 
                    Stevey : Wildcard you better stop! Stop this tractor right now ! 
                    Wildcard simply ignores his cries, as if he did not even notice Stevey was there.
                    Stevey pulls out his gun and shoots Wildcard through the window.
                    Wildcard is dead.
                    """
                    end_game.solveEnding('tractor')
                    @text end_game.getEndingStatus()
                    
                
        'open tractor/use key' : ->
            @text """
            Wildcard uses the tractor key to open the cabin. As soon as he does he notices the a bottle ledged under the seat. 
            Catching his attention he pulls it out and sees it is a half empty bottle of wisky. 
            """
        'get key' : "Wildcard wonders who would have the key."
        'drink bottle/drink it' : """
        Wildcard opens the bottle and and starts gulping it down. 
        Chief, with a cocerned voice says "Wildcard I don't think that's a good ..." but as he finishes his sentence,
        Wildcard raises his finger in a gesture of "wait". 
        Wildcard finishes the bottle. He looks around everything seems distortioned.
        He looses balance and falls against the tractor . He then crumbles to the ground next to it.
        He's no longer able to finish the case.
        """
            
        @dialogue('farmer')
            'ask about bottle' : """
            Wildcard looks at the bottle , he asks "What's with the bottle" as his gaze changes towards the farmer. 
            Farmer gets a bit red, he seems slightly afraid . 
            Farmer : Oh well you know...I augh, didn't actually drink that. That's for home , ya see ? 
            """
            'why is it half empty/why is it under your seat': """
            Wildcard : Why is it under your seat? Half empty ! ; as he shakes the bottle
            Farmer looks now distressed, his eyes wide open . After a moment he calms a bit . 
            Farmer : Ok, OK ! I might have had a bit on the job. You know, it gets boring out here. 
            """   
            
module.exports.farmer = farmer
module.exports.tractor = tractor