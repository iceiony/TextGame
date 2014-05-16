loc = require './locations'

module.exports = (story) ->
  ->
    @location loc.next_to_paramedics
    @text """
    Willy walks to the 2 paramedics resting on the ground next to their equipment. One male and one female. 
    They don't sem to notice the detective approaching, and continue their conversation
    
    Male : You know that they had a balloon race yesterday at the fest.
    Female : Oh that sounds fun . Wish I went.
    Male : Yeah , too bad the storm brought an early end....
    
    Chief clearing his throat attact's the two's attention.
    Female : Oh chief, sorry , we didn't notice you aproaching . Got a bit bored . 
    She says smiling.
    Chief : Well the detective here has been generous to help us with the case. 
            Can you please answer any of his questions .
    Female : "Sure"; she says as she stands up from the ground. 
    The male paramedics stands up as well .
    """  
    @female = "The female"
    @male = "The male"
    
    @location loc.next_to_paramedics, ->
      "what are your names/what is your name" : ->
        @text """
        Wildcard : What are your names ? 
        Female : Ohh I'm Anne and my partner over here is David . 
        David : How do you do sir . he says in low voice and with a short nod of his head.  
        """ 
        @female = "Anne"
        @male = "David"
      'tell me about the body/your examination/what happened/what can you tell me/cause of death/death cause':->
        @text """
        Willy : So what can you tell me .
        The female paramedic starts gesticulating as if counting .
        #{@female} : Well, the victim is male about 90 kilograms, and about 45years old.
                     Cause of death... besides the numerous bone fractures we could notice, he had a skull fracture.
                     What ever it was, he died instantly . At least he didn't to suffer.
                     He died sometime in the middle of last night. Maybe around 2AM . Rigor mortis hasn't settled in yet. 
        """
        @location loc.next_to_paramedics ,->
          "what else/alcohol smell/was he drunk/did you check his blood": ->
            @text """
            Willy : What else can you tell me ? 
            #{@female} : Ohh... There were no bruises. We felt a feint smell of alcohol so we took a bit of blood . 
                         But we didn't find a large level in his blood stream. He probably just had a shot before his immediate death. 
            """
      'tell me about the broken bones/ask about broken bones/ broken bones' : ->
        @text """
        Willy : Do you know why he had so many bones broken ?
        #{@female} looks to her partner. 
        #{@female} : We don't exactly know. It could be he was hit by a large truck or a train, or he fell off a tall building.
        #{@male} : Could be anything . 
        #{@female} : We'll be able to know more after an autopsy .
        """