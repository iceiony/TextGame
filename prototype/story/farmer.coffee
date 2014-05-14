loc = require './locations'

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

module.exports = (story)->
################farmer################
  'what is your name/ask name':->
    @text """
    Willy  : What is your name ?
    With a big smile on his face, the farmer wipes his hands on the back of his pants and extends one to shake the detective's hand. 
    
    Farmer : "Mark Ranch sir , how do you do !" , shakeing the detective's hand in an excited manner.   
    """
    _askName.call(@)
    
  'hello/ greetings' :->
    @text """
    Willy  : Greetings !
    Farmer : Good morning sir.
    """
    'hello/greetings' :-> 
      @text """
      Willy : Good morning !
      Farmer : Yes good morning !
      """

  'what do you do/working on what/what are you working on':->
    @text """
    Willy : What is it that you do Mark ? 
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
    
  'on a Sunday/why Sunday/you work on Sunday/working sunday/what are you doing here sunday':->
    @text """
    Willy : Why you working on a Sunday ?
    Mark's face changes to a serios one. His voice starts trembling . 
    Mark : Because, because... I need to plow this here land . 
    Willy : "Do you usually work on a Sundays?" The detective says squinting his eyes slightly .
    Mark's eyes wide open. He crosses his hands over his chest and says.
    Mark : "Look here I needed to do my job, right ? So that's why I'm here on a Sunday. You can't arrest me for working on Sunday!
           ...Rihtght ?".  He says in an loud slightly agressive manner. 
    As he says that, the detective notices the alcohol filled breath of the farmer. He's been drinking. 
    """
    
  "you have been drinking/drunk/drunk driving/drunk at work": ->
    @text """
    Willy : You've been drinking. I can arrest you for drinking Mark.
            What are you doing here on a Sunday morning drunk and driving a tractor ?
    Mark seems scared now, he pleads to Willy and the officers : 
    Mark  : Look I came here to work! Sure I had a bit to drink, but I didn't hurt no body? 
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
        Chief : What about the body, why are all the bones broken ? What if he ran the fella down with his tractor ?
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
            Willy : You know what we think Mark ? We think you hit this poor fellow with your tractor and then called us.
            With dispayr and a bit of anger Mark responds.
            Mark  : No... NO ! I didn't run anyone down. I was here to work, I had to finish the job since I didn't yesterday.
                    Because the storm hit yesterday evening and I couldn't stay till late to finish !

            Chief wispers to Wildcard. 
            Chief : Do you believe him Willy ? 
            """ 
            @location loc.next_to_tractor,->
              'yes' : ->
                @text """
                Willy : I believe him
                Chief : Well I still don't like that he's drunk driving. I might arrest him for just that .
                Chief turns to the farmer.
                Chief : Why are you drunk Edd ? Why did you come here like this ? You know I can arrest you for just that ! 
                Farmer : Ok , please don't ! You see this place here is empty there's nothing to do. There ain't no one for an 1 distance. 
                         So I thought, you know , what is the harm?  
                Chief : Now how do I know you didn't drive here drunk and hit this fellow on the way here ?
                Farmer : "No ! I didn't, I swear !" ; Mark desperately pleads
                """
              'no'  : ->
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
            Farmer : I bet you never do .
            """
        
  'you found the body/how did you find the body/when did you find the body' :->
    @text """
    Willy  : Tell me how you found the body .
    Farmer : I got here about 5AM this mornign. Because of the storm last night , the earth is soft so easier to work with the tractor.
             So I was about 100 meters in from the road when I notice something in the distance. I couldn't tell what it was. 
             But I stopped the tractor to check it out. When I got close I saw it was a person lying there. Not moving.
             So I thought to myself , this guy is dead. So then I rushed to my tractor , drove to the nearest phone and called the police.
    """
################tractor###############
  'drive tractor/drive it/drive':->
    @text "You don't have a key you silly duck!"
    @location loc.next_to_tractor, ->
      'drive tractor/drive it/drive': ->
        @text "Quack quack..."