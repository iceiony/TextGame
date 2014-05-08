module.exports = (story) -> {
'Cigar/Fag/Smoke/have a smoke': ->
  @clearGeneral()
  @text """ 
          With a content look on his face, Willy starts to collect his thoughts. He reaches to the inside of his jacket and pulls out a cartridge of cigars and a lighter. 
          He takes one puff and looks satisfied. As he seems to about to say something he starts coughing violently and falls to the ground.
          Paramedics at the scene of the crime rush to save him. They conclude it's cancer and fail to save the detective. He dies within a few minutes. 
          Henry : "Such a shame" shaking his head in denial. 
          Chief : "This is what you get when smoking. Rest in peace Wildcard."
          (Type respawn to start from begining)
          """
  @general ->
    'respawn/restart': story.intro
    'default': story.death
###################################################    
    
'': ->
  @text """
        Wildcard seems like he's about to say something. He raises his hand in a gesture which seems that he's about to make a point. 
        But tilts his head in a matter of confusion.
        The chief looks at him patiently. 
        """
  @general ->
    '': ->
      @text """
              Wildcard sits in silence. He doesn't look like he's about to say or do anything. 
              Chief gains a crious look in his eyes : "Willy ?"
              """
      @general ->
        '': ->
          @text """
                5 minutes pass. Everyone is frozen still waiting for Wildcard to take action.
                Chief : Com on detective, say something! What's the matter?
                Chief gazez over to the paramedics with a thought to call them over. They notice his gaze and set up as if ready to answer the urgent call. 
                """
          @general ->
            '': ->
              @clearGeneral()
              @text """
                    From behind the chief, Stevey pulls a gun. In a blink of an eye, he shoves the Chief aside points the gun at Wildcard and pulls the trigger.
                    Wildcard falls to the ground . Henry and the Chief jump on Stevey to dissarm him. 
                    The paramedics nearby rush to save Wildcrad. But he's dead, shot through the heart.
                    """
              @general ->
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
  @general ->
    'coffee/give me coffee': ->
      @text """Chief : "Stevey on the way to get you one Willy. Can we please focus on the crime scene for now ." """
      @general ->
        'coffee/give me coffee': ->
          @text """Cheif: Look I know it's quite an early Sunday morning, but we all want to finish this and go home. """
          @general ->
            'coffee/give me coffee': ->
              @text """
                    Chief looks a bit irritated now.
                    Chief:"Look Willy, I know you have your issues. But we quite need your head on this case. Now please focus for a moment."
                          "We're in the middle of nowhere early Sunday morning, we want to finish this fast" """
              @general ->
                'coffee/give me coffee': ->
                  @text """Chief acts as if he doesn't even hears the the word. Stares Willy dead cold in the eyes """
                  @general ->
                    'coffee/give me coffee': ->
                      @text """
                            Willy leans to his bag next, reaches in and pulls out a coffee cup. He extends his hand to give it to the chief.
                            He looks straight back into the Chief's eyes and repeats.
                            Willy: "Coffee"
                            The chief hesitantly takes the coffee, his concerned eyes shifting between the cup end Wildcard's serious stare.
                            Chief: " Thanks... " he says with some hesitance in the voice

                            Willy proceeds to give pull out more cups for the people around . 
                            He hands one to Henry, another two to the paramedics and one last one to the farmer sitting next to his parked tractor."""
                      @general ->
                        'coffee/give me coffee' : ->
                          @text """
                                       Chief: "Yes, thanks for the coffee Willy, it was an...unexpected treat "
                                       As he raises his coffee cup in appreciation  he looks around as the surrounding party approves."""
}
  