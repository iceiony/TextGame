_unconciousBeating = (story)->
  @clearGeneral()
  @everywhere ->
    'restart/respawn/start/new': story.intro
    'default':->
      @text """
          Wildcard is unconcious. He can not continue the investigation.
          [Type respawn to start from begining]
          """

module.exports = (story) -> {
'Cigar/Fag/Smoke/have a smoke': ->
  @clearGeneral()
  @text """ 
          With a content look on his face, Willy starts to collect his thoughts. He reaches to the inside of his jacket and pulls out a cartridge of cigars and a lighter. 
          He takes one puff and looks satisfied. As he seems to about to say something he starts coughing violently and falls to the ground.
          Paramedics at the scene of the crime rush to save him. They conclude it's cancer and fail to save the detective. He dies within a few minutes. 
          Henry : "Such a shame" shaking his head in denial. 
          Chief : "This is what you get when smoking. Rest in peace Wildcard."
          """
  @everywhere ->
    'default': story.death
#####################################################                
    
'': ->
  @text """
        Wildcard seems like he's about to say something. He raises his hand in a gesture which seems that he's about to make a point. 
        But tilts his head in a matter of confusion.
        The chief looks at him patiently. 
        """
  @everywhere ->
    '': ->
      @text """
              Wildcard sits in silence. He doesn't look like he's about to say or do anything. 
              Chief gains a crious look in his eyes : "Willy ?"
              """
      @everywhere ->
        '': ->
          @text """
                5 minutes pass. Everyone is frozen still waiting for Wildcard to take action.
                Chief : Com on detective, say something, doo something , look around! 
                        I can't tell you how to do your job...
                        What's the matter?
                Chief gazez over to the paramedics with a thought to call them over. They notice his gaze and set up as if ready to answer the urgent call. 
                """
          @everywhere ->
            '': ->
              @clearGeneral()
              @text """
                    From behind the chief, Stevey pulls a gun. In a blink of an eye, he shoves the Chief aside points the gun at Wildcard and pulls the trigger.
                    Wildcard falls to the ground . Henry and the Chief jump on Stevey to dissarm him. 
                    The paramedics nearby rush to save Wildcrad. But he's dead, shot through the heart.
                    """
              @everywhere ->
                'default': story.death
                
#####################################################                
                
'coffee/give me coffee': ->
  @text """
          Chief : "Coffee ?" A bit of a confused look could be noticed on the chief's face. 
          Chief : Stevey , you heard the man, get him a coffee . 
          Stevey: Coffe ? But we're in the middle of nowhere, where the heck am I going to get coffee here. The nearest town is an hour away.
                  Chief turns around with an angry look in his eyes. Stevey suddenly realises his mischief. 
          Stevey: Yes sir , chief. On my way!  As he starts rushing to the cars in the distance. 
          Cheif turns back to the detective: "Well that will probably take him a while . Shall we continue meanwhile ?" """
  @steveyLeft = true
  @everywhere ->
    'coffee/give me coffee': ->
      @text """Chief : "Stevey on the way to get you one Willy. Can we please focus on the crime scene for now ." """
      @everywhere ->
        'coffee/give me coffee': ->
          @text """Cheif: Look I know it's quite an early Sunday morning, but we all want to finish this and go home. """
          @everywhere ->
            'coffee/give me coffee': ->
              @text """
                    Chief looks a bit irritated now.
                    Chief:"Look Willy, I know you have your issues. But we quite need your head on this case. Now please focus for a moment."
                          "We're in the middle of nowhere early Sunday morning, we want to finish this fast" """
              @everywhere ->
                'coffee/give me coffee': ->
                  @text """Chief acts as if he doesn't even hears the the word. Stares Willy dead cold in the eyes """
                  @everywhere ->
                    'coffee/give me coffee': ->
                      @text """
                            Willy leans to his bag next, reaches in and pulls out a coffee cup. He extends his hand to give it to the chief.
                            He looks straight back into the Chief's eyes and repeats.
                            Willy: "Coffee"
                            The chief hesitantly takes the coffee, his concerned eyes shifting between the cup end Wildcard's serious stare.
                            Chief: " Thanks... " he says with some hesitance in the voice

                            Willy proceeds to give pull out more cups for the people around . 
                            He hands one to Henry, another two to the paramedics and one last one to the farmer sitting next to his parked tractor."""
                      @everywhere ->
                        'coffee/give me coffee' : ->
                          @text """
                                       Chief: "Yes, thanks for the coffee Willy, it was an...unexpected treat "
                                       As he raises his coffee cup in appreciation  he looks around as the surrounding party approves."""
#####################################################   
'go north/walk north' :->
  @text """
  Wildcard attempts to take a step forward. But he can't . The chief is in the way .
  """
'go west/walk west' :->
  @text """
  Withouth a word , wildcard turns to his left and heads west. 
  He passes right between two paramedics and a farmer and his tractor. But he keeps going.  
  """
  @everywhere ->
    'go east/walk east' :-> 
      @text """
      Wildcard returns in front of the police offiers. 
      Stevey leans towards henry and asks in a whisper .
      Stevey : What is happening ?
      Henry : Oh, I don't know. That's how he is. Just unusual.
      Stevey : Oh...
      """
'go south/walk south' :->
  @text """
  Wildcard turns around and walks all the way back to the car. He then gets in and drives back home.
  [The End]
  """
  @clearGeneral()
  @everywhere ->
    "default" :->
      @text """
      Wildcard has left the game.... You can not continue withouth him.
      Type "restart" to start from begining .
      """
'go east/walk east' :->
  @text """
  Wildcard turns right and walks straight. He walks that direction for a while. Should he continue ?
  """
  @everywhere ->
    'continue east/go east/walk east/continue/yes' :->
      @clearGeneral()
      @text """
      Walks keeps walking, and walking and walking. He is far in the distance now from where he started. 
      But he keeps walking.
      After a few minutes Wildcard is in the middle of nowhere, or anywhere. What ever you'd like to call it.
      But he keeps walking.
      After a few hours Wildcard reaches the edge of the map.
      But he keeps... walkign .
      Wildcard falls off the map and dies. 
      [Type, 'I am wildcard' , to start from begining]
      """
      @everywhere ->
        'restart/respawn/start/new': story.intro
        'I am wildcard' : ->
          @text """
          You sure are... Get Out !
  
          [ you have been kicked out of the game ]
          """
          story.exit()
#####################################################   
'punch' :->
  @text """
Wildcard arms his fist. But he has no target. So he airpunches as if in celebration. 
People around him smile not knowing the evil motives behind his actions .
"""
'punch chief' :->
  @text """
  Wildcard arms his fist . He takes a swing at the chief, whom with his keen sense dodges by making one step back. 
  Chief : Ohooohooo , I'm not that old yet boy . I see you're still testing me like every time . 
  He smiles, taking Wildcard's actions as an ill joke. 
  """
'punch henry' :->
  @text """
  Wildcard arms his fist. His sight gets fixed on Henry, he squints his eyes and steps towards him.
  But Henry steps behind the chief. He's not leaving a clear line between himself and Wildcard.
  They go around and around the chief for a while untill eventually, Willy gets bored and gives up . 
  """
  
'punch farmer' :->
  @text """
  Wildcard arms his fist. He looks at the farmer, but disarms it. 
  The farmer reminds him of his dead. Willy's dad is not around anymore. Actually he's all alone in the world now...
  """
  @everywhere ->
    'punch farmer' :->
      @text """
      Willy thinks ["What the heck. I can't live in my past for ever."] 
      He arms his fist and in a swift move hits the farmer in the stomach. 
      Farmer Mark, falls coiled to the ground . He is on his knees. 
      The chief abrublty grabs Willy by the soulder turns him around and shouts:
          
          God darn it, what was that for ? What are you thinking boy ! Have you lost your mind completely ?!
      
      While Willy was being lectured. The farmer strugles to get back up holding his arm against the abdomen.
      He reaches into the tractor's cabin and pulls out a bottle of wisky.
      Withouth hesitance he smashes it against Wildcar's head.  
      
      [Wildcar falls unconcious]
      """
      _unconciousBeating.call(@,story)
          
'punch female paramedic/punch ann':->
  @text """
  Wildcard arms his fist. Little does he know that Ann , the female paramedic is a high ranking free style fighter. 
  She peeks up on Wildcard movement and goes into a deffensive position. 
    Ann : You'll get me that easily big boy. 
  Discouraged by her swift reaction . Wildcard halts his attempts to attack. 
  """
'punch male paramedic/punch david':->
  @text """
  With a lightning move, Wildcard punches David in the face. 
  David falls on his backside holding his nose, expressing sounds of pain. 
  From Wildcard's right, a hand reaches to the detective's shirt, gripping it tightly. 
  As the detective shifts his sight, he is confrunted with a straight fist in the face.
  
  Things get a bit blury... time becomes dilated.. . 
  As Willy is barely able to make out the perpetrator's identity , a second straight hits the detective face. 
  
  Willy : Ann ....
  
  [Wildcard is now unconcious]
  """
  _unconciousBeating.call(@,story)
  
'punch stevey' :-> 
  @text """
  Wildcard arms his fist. He goes straight for Stevey.
  But upon getting close, he feels a the killing instict of the man, as he does not move a muscle. 
  Stevey's serious stare crubles Wildcard's attempt. 
  Wildcard realises he doesn't  want to puch Stevey. He radiates a dangerous aura for a kid his age. 
  """
  @everywhere ->
    'punch steve':->
      @clearGeneral()
      @text """
      Wildcard makes courage. He arms his fist... and foot. He's dangerously serious now. 
      He dragon kiks Stevey who, how ever overwelming he seemed, falls to the ground. 
      Wildcard smirks in satisfaction. 
      Stevey pulls out his gun and shoots Wildcard. You could feel the hateful glare in his eyes.
      [Wildcard is dead]
      """
      @everywhere ->
        'default': story.death
}
  