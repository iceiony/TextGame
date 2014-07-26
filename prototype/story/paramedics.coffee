female = "The female"
male = "The male"

module.exports = ->
    @text """
    Willy walks to the 2 paramedics resting on the ground next to their equipment. One male and one female.
    They don't sem to notice the detective approaching, and continue their conversation

    Male : You know that they had a balloon race yesterday at the fest.
    Female : Oh that sounds fun. Wish I went.
    Male : Yeah, too bad the storm brought an early end....

    Chief clearing his throat attact's the two's attention.
    Female : Oh chief, sorry, we didn't notice you aproaching. Got a bit bored.
    She says smiling.
    Chief : Well the detective here has been generous to help us with the case.
            Can you please answer any of his questions.
    Female : "Sure"; she says as she stands up from the ground.
    The male paramedics stands up as well.
    """
    @dialogue('anne')
        'hello' :
            """
            Wildcard : Hello.
            Paramedic : Well hello.
            """
        'what is your name/what are your names' : ->
            @text """
            Wildcard : What are your names?
            Female : Ohh I'm Anne and my partner over here is David.
            David : How do you do ; He says in low voice and with a short nod of his head.
            """
            female = "Anne"
            male = "David"

        'ask about the body/cause of death/what did you discover' : """
        Willy : So what can you tell me.
        The female paramedic starts gesticulating as if counting.
        #{female} : Well, the victim is male about 90 kilograms, and about 45years old.
                     Cause of death... besides the numerous bone fractures we could notice, he had a skull fracture.
                     What ever it was, he died instantly. At least he didn't suffer.
                     He died sometime in the middle of last night. Maybe around 2AM. Rigor mortis hasn't settled in yet.
        """

        'ask for more/alcohol smell/was he drunk/did you check his blood' : """
        Willy : What else can you tell me?
        #{female} : Ohh... There were no bruises. We felt a faint smell of alcohol so we took a bit of blood.
                     But we didn't find a large level in his blood stream. He probably just had a shot before his immediate death.
        """

        'about the broken bones' : """
        Willy : Do you know why he had so many bones broken?
        #{female} looks to her partner.
        #{female} : We don't exactly know. It could be that he was hit by a large truck or a train, or he fell off a tall building.
        #{male} : Could be anything .
        #{female} : We'll be able to know more after an autopsy.
        """

        'ask about the balloon race' : """
        Willy : What can you tell me about the ballon race?
        #{male} : Oh, there is this festival a few towns away. They have balloon flights and races.
                  I was there last night before the storm hit...
                  What does it have to do with anything?
        """
