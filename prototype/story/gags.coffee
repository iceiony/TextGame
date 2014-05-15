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
                Chief : Com on detective, say something! What's the matter?
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
}
  