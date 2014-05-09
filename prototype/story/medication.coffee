module.exports = (story)->
  "take medication": ->
    @text """
    Wildcard reaches into his pockets. He pulls out an orange perscription bottle, half full with pills. 
    As he pops one out he realises he needs something to drink it with. 
    """
    @everywhere ->
      "get water/ask for water/request water/give me water": ->
        @text """
        Out of nowhere Henry pops out with a bottle of water. He hands it over to the detective. 
        Wildcard swallows the pill and takes one gulp of water. It went down easily .
        """
      "take medication/drink water": ->
        @text """
        Wildcard swallos the pill. 
        """
        @everywhere ->
          "take medication": ->
            @text """
            Wildcard pops another pill and swallows it.
            """
            @everywhere ->
              "take medication": ->
                @text """
                Wildcard pops another pill and swallows it. It's not going down as easily.
                """
                @everywhere ->
                  "take medication": ->
                    @clearGeneral()
                    @text """
                    Wildcard pops another pill. Something happens. The whole world around him becomes black. 
                    
                    [....an undetermined amount of time passes....]
                    
                    In a bed in a dark room, with a hazy site, an individual wakes up. He tries to make sense of where he is and what has happend.
                    Individual : What happend, I was just now... The case. 
                    His wandering gaze falls on the nightstand next to his bed. On top of it is an orange bottle of perscription pills. 
                    
                    Individual : ohh yes, I've dreamt again... I'm no longer a detective... not in a long time. 
                    His hand falls over his eyes in a weeping gesture. But you wouldn't hear a sound, just a long sigh... 
                    """
                    @everywhere ->
                      "default" : ->
                        @text """
                        The End
                        {Type restart to fall back asleep}
                        """
                        @everywhere ->
                          'restart/respawn/start/new': story.intro
