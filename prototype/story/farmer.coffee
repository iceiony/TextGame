loc = require './locations'
module.exports = (story)->
################farmer################
  'what is your name/ask name':->
    @text """
    Willy  : What is your name ?
    With a big smile on his face, the farmer wipes his hands on the back of his pants and extends one to shake the detective's hand. 
    
    Farmer : "Mark Ranch sir , how do you do !" , shakeing the detective's hand in an excited manner.   
    """
  'hello/ greetings' :->

  'what do you do/working on what':->
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
  'wtf' :->
    @text """
    Willy : WTF ?
    While scratching his head with a dumb look on his face Mark says:
        "I don't know what you want mister" 
    """
  'lol' :->
    @text """
    Willy laughs histerically : " HaHahAhAhahaha!"
    Marks is not smiling anymore . He's expression looks panicky, while looking at the detective's unrequired display.
    """
  'on a Sunday/why Sunday/you work on Sunday/working sunday?':->
    @text """
    Willy : Why you working on a Sunday ?
    Mark's face changes to a serios one. His voice starts trembling . 
    Mark : Because, because... I need to plow this here land . 
    Willy : "Do you usually work on a Sundays?" The detective says squinting his eyes slightly .
    Mark's eyes wide open. He crosses his hands over his chest and says.
    Mark : "Look here I needed to do my job right ? So that's why I'm here on a Sunday. You can't arrest me for working on Sunday!
           ...Rihtght ?".  He says in an loud slightly agressive manner. 
    As he says that, the detective notices the alcohol filled breath of the farmer. He's been drinking. 
    """
  "you have been drinking/drunk/drunk driving": ->
    @text """
    Willy : You've been drinking. I can arrest you for drinking Mark.
            What are you doing here on a Sunday morning drunk ?
    Mark seems scared now, he pleads to Willy and the officers : 
    Mark  : Look I came here to work! Sure I had a bit to drink, but it didn't hurt anybody ? 
    Willy : What about the body ? How did it get here ? 
    Mark  : "I don't know how it got here !" he says in a loud tone gesticulating with his right hand towards the detective. 
            Why did I call you fellas in the first place ? 
    
    [....a moment of silence....]
    
    The chief pulls Willy's coat a bit and wispers in his ear ? 
    Chief : What do you think willy? Think he did it  ?
    """
    @location loc.next_to_tractor,->
      "no" :->
        @text """
        Willy wispers back .
        Willy : No, not yet, but I need to question him more to find out .
        """
      "not yet/don't know" : ->
        @text """
        Willy wispers back .
        Willy : No, not yet, but I need to question him more to find out .
        """ 
      "yes":->
        @text """
        Willy : Yes. For sure !
        Chief : What about the body, why are the bones broken ?
        """
      "hit by tractor/hit with tractor/run over": ->
        @text """
        Willy : He ran the victim over with the tracor, while drunk .
        Chief : I see , I see. We won't know for certain until the autopsy.
        Chief looks at Mark, the farmer .
        Chief : Where were you last night ?
        Mark  : I was home. 
        Chief : Anyone home with you  ?
        Mark  : No. I live by myself. 
        Chief : Ok Henry cuff him . You're under arest Mark.
        
        Mark : "But I didn't do nothing.", he says and struggles as Henry was puttin on the hand cuffs .
        """
      
  'you found the body' :->
################tractor###############
  'drive tractor/drive it/drive':->
    @text "You don't have a key you silly duck!"
    @location loc.next_to_tractor, ->
      'drive tractor/drive it/drive': ->
        @text "Quack quack..."