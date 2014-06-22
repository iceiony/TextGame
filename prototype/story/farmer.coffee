module.exports.tractor = ->
    @text """
    The detective walks to the the front of the tractor. 
    He leans to one side and observes the back of it is geared up with a plow to prepare the earth for seeding.  
    You touch the tractor's front motor to see if it has been in use recently. But it feels cold to the touch.
    
    The farmer sitting next to it stands up as the detective approaches."""

module.exports.farmer = ->
    @text """
    Willy walks to the farmer. Middle aged man, dirty black hands, with a bit of a red face.
    He was sitting on the ground but stands up as the detective approaches .
    """

old = ->
    _askName = ->
        @location loc.next_to_tractor , ->
        "what is your name/ask name" : ->
            @text """
            Willy : what was your name again ?
            Farmer : Mark Ranch, but people call me Edd.
            """
            @location log.next_to_tractor , ->
                'what is your name/ask name' :->
                    @text """
                Willy : I forgot your name, what was it ? 
                Farmer : Mark Ranch, or Edd. 
                """
               
    ################farmer################
    'what is your name/ask name':->
        @text """
        Willy  : What is your name ?
        With a big smile on his face, the farmer wipes his hands on the back of his trousers and extends one to shake the detective's hand. 
        
        Farmer : "Mark Ranch sir , how do you do !" , shaking the detective's hand in an excited manner.   
        """
        _askName.call(@)
    
    'hello/greetings/hey/hi' :->
        @text """
        Willy  : Greetings !
        Farmer : Good morning sir.
        """
    @location loc.next_to_tractor, ->
      'hello/greetings/hey/hi' :-> 
        @text """
        Willy : Good morning !
        Farmer : Yes good morning !
        """
      'how do you do' :->
        @text """
        Willy : How do you do ?
        Farmer: I'm ok now. I was a bit shooken up about the findings earlier. But I'm ok now.
        """
    'where are you from' :->
        @text """
        Detective : Where are you from ?
        Farmer : Oh I live a few miles a way. Near a small town. I'm not exactly in town.
                 I keep to myself ... 
        """
    'what do you do/working on what/what are you working on':->
        @text """
        Willy : What is it that you do ? 
        Mark  : "I drive this here tractor to plow the land for seeding", he says as he pridefully rests against the tractor.
        
        For some reason , Mark seems a bit tipsy and the detective notices. 
        """
    
    'why':->
        @text """
        Willy : Why ?
        Mark  : Why what ?
        """  
    @location loc.next_to_tractor ,->
      'why' : -> 
        @text """
        Willy : Why ?
        Mark  : Why what ? 
        [.....you can tell this conversation is going places.....]
        """
        
    'wtf/what the fuck' :->
        @text """
        Willy : WTF ?
        While scratching his head with a dumb look on his face Mark says:
            "I don't know what you want mister" 
        """
    
    'lol/haha/hahaha' :->
        @text """
        Willy laughs histerically : " HaHahAhAhahaha!"
        Marks is not smiling anymore . He now seems a bit scared of the detective's unrequired display.
        """
    
    'why Sunday/you work Sunday/working sunday':->
        @text """
        Willy : Why you working on a Sunday ?
        Mark's face changes to a serios one. His voice starts trembling . 
        Mark : Because, because... I need to plow this here land . 
        Willy : "Do you usually work on a Sundays?" The detective says squinting his eyes.
        Mark's eyes wide open. He crosses his at his chest and says.
        Mark : "Look here I needed to do my job, right ? So that's why I'm here on a Sunday. You can't arrest me for working Sunday!
               ...Rihtght ?".  He says in a loud slightly agressive manner. 
        As he says that, the detective smells the alcohol filled breath of the farmer. He's been drinking. 
        """
    
    "you have been drinking/drunk/drunk driving/drunk at work/drinking": ->
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
    @location loc.next_to_tractor,->
      "not yet/don't know/No" : ->
        @text """
        Willy wispers back .
        Willy : No, not yet, but I need to question him more and find out what he was up to.
        """ 
      "yes":->
        @text """
        Willy : Yes. For sure !
        Chief : What about the body, why are all the bones broken ? What if he ran the fella over with his tractor ?
        """
        @location loc.next_to_tractor, ->
          "no/don't think so" : ->
            @text """
            Willy : I don't think so
            Chief : Ok Will , I trust your judgement
            """
          
          'hit by tractor/hit with tractor/run over/yes' :->
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
            @location loc.next_to_tractor,->
              'yes/i believe him' : ->
                @text """
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
              "no/ I don't"  : ->
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
            
      "hit by tractor/hit with tractor/run over": ->
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
        
        [The End]
        """
    'who is edd' : ->
        @text """
        Willy : Who is Edd ? 
        Farmer : Why I am sir. People call me Edd ?
        """
    @location loc.next_to_tractor , ->
      "i thought you are Mark/wasn't your name Mark/ your name is Mark":->
        @text """
        Willy : Wasn't your name Mark?
        Farmer : Yes sir, Mark Ranch .
        Willy : How do you get Edd from Mark  ?
        Farmer : You ask politely .
        """
        @location loc.next_to_tractor , ->
          "i don't get it/what do you mean ?" :->
            @text """
            Willy : I don't get it
            Farmer : You never do, I bet ! ; he laughts in a sly manner.
            """
    'did you know him/have you ever seen him before': ->
        @text """
        Willy : Did you happen to know the victim ? 
        Farmer : Well , when I realised he's dead, I got so frightent that I didn't get a good luck at him.
                 But he didn't look familiar... And I don't get to meet a lot of people so I don't know him.
        """
    'you found the body/how did you find the body/how did you find it/ask about body' :->
        @text """
        Willy  : Tell me how you found the body .
        Farmer : I got here about 5AM this morning. Because of the storm last night , the earth is soft so it's easier to work it with the tractor.
                 So I was about 100 meters in from the road when I notice something in the distance. I couldn't tell what it was. 
                 But I stopped the tractor to check it. When I got close I saw the person lying there, not moving.
                 So I thought to myself , this guy is dead. And then I rushed to my tractor , drove to the nearest phone and called the police.
        """
    @location loc.next_to_tractor,->
      'tell me more/ask for more/question more/anything else': ->
        @text """
        Willy : Anything else you can share ?
        Farmer : That's all I know detective. 
        """
    ################tractor###############
    'drive tractor/drive it/drive':->
    @text "You don't have a key you silly duck!"
    @location loc.next_to_tractor, ->
      'drive tractor/drive it/drive': ->
        @text "Quack quack..."
      'get key/ask farmer for key/ask for key/look for key':->
        @text """
        Wildcard : Can I get the key to the tractor ? 
        Farmer : Uhm , sure mister. But what you wanna search in there for ? 
        Wildcard : I have my reasons .
        The farmer reaches into his shirt pocket and pulls out a key which he hands to the detective. 
        [ ....Wildcard has aquired the tractor key.... ] 
        """
        @location loc.next_to_tractor , ->
          'open tractor/use key' : ->
            @text """
            Wildcard uses the tractor key to open the cabin. As soon as he does he notices the a bottle ledged under the seat. 
            Catching his attention he pulls it out and sees it is a half empty bottle of wisky. 
            """
          'what is this doing here/who does this belong to/what is with the bottle': ->
            @text """
            Wildcard looks at the bottle , he asks "What's with the bottle" as his gaze changes towards the farmer. 
            Farmer gets a bit red, he seems slightly afraid . 
            Farmer : Oh well you know...I augh, didn't actually drink that. That's for home , ya see ? 
            """
            @location loc.next_to_tractor , ->
              'why is it half empty/why is it under your seat' : ->
                @text """
                Wildcard : Why is it under your seat? Half empty ! ; as he shakes the bottle
                Farmer looks now distressed, his eyes wide open . After a moment he calms a bit . 
                Farmer : Ok, OK ! I might have had a bit on the job. You know, it gets boring out here. 
                """
                
          'drink bottle/drink it' :->
            @clearGeneral()
            @text """
            Wildcard opens the bottle and and starts gulping it down. 
            Chief, with a cocerned voice says "Wildcard I don't think that's a good ..." but as he finishes his sentence,
            Wildcard raises his finger in a gesture of "wait". 
            Wildcard finishes the bottle. He looks around everything seems distortioned.
            He looses balance and falls against the tractor . He then crumbles to the ground next to it.
            He's no longer able to finish the case.
            """
            @everywhere -> 
              'default' : ->
                @text """
                The chief stares at the detective in dread.
                Chief : "Wildcard's hammered..."
                {Type respawn to start from begining}
                """
                @everywhere ->
                  'restart/respawn/start/new': story.intro
            
          'drive tractor/drive it/drive' :->
            @clearGeneral()
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
            @everywhere ->
              'default': story.death