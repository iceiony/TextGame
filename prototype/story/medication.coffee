module.exports = (story)->
    @text """
    Wildcard : What's your name chief?
    The officers gain a bit of a shoked expressions on their faces.
    The chief slowly leans towards Wildcard and asks : 
    Chief : Son, are you ok ? Have you been taking your medication properly ? You know who I am right ? 
    """
    
    @action 
        'take medication/check pockets' : [ """
        Wildcard reaches into his pockets. He pulls out an orange perscription bottle, half full with pills. 
        As he pops one out realises he needs something to drink it with. 
        """
        ]

    @dialogue('chief')
        'yes' : """
        Wildcard : Yes !
        Chief: Good ! Don't scare me like that.... Let's solve this case then ! Shall we ?
        """
        'no' : """
        Wildcared : No...
        Chief looks even more shoked. 
        Chief: I know you since you were kid. How can you forget my name ? 
               I think you should take your medication now. It's not good if you skip it. 
        Wildcard usually takes it with his morning coffee. But on this ocassion he had to skip breakfast to respond 
        to the urgent crime call.
        """
        'what medication' : """
        Wildcard : What medication ?
        Chief : Check your pockets son . 
        """
        'ask for water': [ """
            Wildcard : Anyone have a drink ? 
            
            Out of nowhere Henry pops out with a bottle of water. He hands it over to the detective. 
            Wildcard swallows the pill and takes one gulp of water. It went down easily .
            """
            
            "Wildcard swallows the pill."
            "Wildcard pops another pill and swallows it."
            "Wildcard pops another pill and swallows it. It's not going down as easily."
            
            """
            Wildcard pops another pill. Something happens. The whole world around him becomes black. 
            
            [....an undetermined amount of time passes....]
            
            In a bed in a dark room, with a hazy site, an individual wakes up. He tries to make sense of where he is and what has happend.
            Individual : What happend, I was just now... The case. 
            His wandering gaze falls on the nightstand next to his bed. On top of it is an orange bottle of perscription pills. 
            
            Individual : ohh yes, I've dreamt again... I'm no longer a detective... not in a long time. 
            His hand falls over his eyes in a weeping gesture. But you wouldn't hear a sound, just a long sigh... 
            """
        ]
        
#    
#old = ->
#    @text """
#    The End
#    {Type restart to fall back asleep}
#    """
    
