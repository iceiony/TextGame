#locations 
start = "start"
next_to_tractor = "next to tractor"
next_to_paramedics = "next to paramedics"

story = {
  intro: ->
    @location start
    @text """
    Crime scene investigation
    Location : Middle of an empty field . Early hours of Monday morning. 
    
    Officer in charge : "this is an odd one Henry, think we need to call you know you."
    Henry :             "You mean, THAT guy."
    Stevey:             "Oh ! Surely not that oddball. What are you getting him for ?!"
    Chief :             "Well he's odd alright. But still oddly better than the lot of us put together."
    Henry :             "I'll give him a call chief." 
    (Steveey's expression changes to disapproval)
    
    [.........1 hour later.........]

    Far in the distance you can see a car stop, old mustang, a muscle car. Driver steps out , head slowly towards the group of policeman . 
    Behind the chief are the 2 assisting officers, sitting next to each other
    Chief: "Detective Wildcard, glad to see you son"
    (Stevey with some disbelief leans towards Henry.
    (Stevey " Is this the guy ?")
    (Henry  "Yep.")
    (Stevey "he doesn't seem all that" )
    (Henry  "Yep")
    (Stevey "So he's name IS Wildcard" )
    (Henry  "Yep")
    (Stevey "That's a bit odd isn't it")
    (Henry  "Yep")
    
    Cheif: "Thanks for doing us the favour and coming down. This is an odd one and we kind of hit a wall here. Can't figure it out , that's why we need your help Willy." 
    (Stevey: "Hrhrhrhaharrr!" , swalowing his laughter ) 
    (Chief turns around with a criticising look. He then leans towards Willy and says : "Don't mind the rookie. He's a good kid" ) 
    Chief: "So Detective!" the chief says in a lewder voice while corner eyeing the two officers behind him. 
           "We'll provide what ever you require. Just let us know what you need to solve this case."
    """
    @location start, ->
      'look around/examine surroundings/analyse area': ->
        @text """
        There are 5-6 other people present: the three officers, 2 paramedics and a farmer. He's sitting by his tractor, parked a about 20 meters away towards the road.
        Behind the policeman, about 10 meters away you notice the body of a victim. 
        """
        @knowsAboutBody = true 
      "Greetings/Hello":->
        @text """
        Chief: "Oh where are my manners? Greetings Wildcard, excuse me for skiping the introductions son." 
               "I have with me Henry and Stevey. You've met Henry before, and Stevey is straight from the academy"
        """
        @location start, ->
          "your name/chief's name/what is your name chief": story.chief_name
            
      "What's the case/What's up/What's the situation/What am I seeing/Information/Details/Situation/What is going on/What have we got/What happened/ask about the case": ->
        if @knowsAboutBody 
          @text "The chief turns around and starts walking towards the body."
        else
          @text "The chief turns around and starts walking towards a body, located about 10 meters behind the policeman. "
          
        @text """
        Chief : "We got the call at 5AM this morning for a body found in the middle of the field."
            "The call was made by Mike Rachid over there, who was plowing in the vicinity." The chief points towards a farmer sitting next to his tractor."
            "Given the remote location, we arrived at the scene 1 hours later. [Body is faced up, a middle aged white male, maybe 45, half naked.] "
            "We weren't able to identify him yet and no reports of missing people from nearby towns."
        """
      'witness/anyone around': ->
        @text """
        Chief looks towards a nearby tractor. The tractor driver resting against it. 
        Chief: "Mike Rachid over there found the body. We don't have any other weakness besides him."
        """
        
    @everywhere -> require('./gags')(story)
    @everywhere ->
      "chief's name/what is your name chief": story.chief_name
      'Body / Look at body / Go to body/ inspect body': require('./body')(story)
      'tractor/inspect tractor/examine tractor/go to tractor': ->
        @location next_to_tractor
        @text """
        The detective walks to the the front of the tractor. 
        He leans to the side and observes the back of it is geared up with a plow to prepare the earth for seeding.  
        You touch the tractor's front motor to see if it has been in use recently. But it feels cold to the touch.
        """
      'Paramedics/go to paramedics/talk to paramedics': ->
        @location next_to_paramedics
        @text """
        Willy walks to the 2 paramedics resting next to their equipment. 1 Male and one female. 
        They don't look particularly enthusiastic and don't actually notice the detective approaching.
        """
      'farmer/go to farmer/talk to farmer' : ->
        @location next_to_tractor
        @text """
        Willy walks to the farmer. Middle aged man, looks hard working. He was sitting on the ground but stands up as the detective approaches .
        """
      'default': ->
        @text """ Wildcard mutters something indistinguishable """
        
  chief_name: ->
    @text """
    Wildcard : "What's your name chief?"
    The officers gain a bit of a shoked expressions on their faces.
    The chief slowly leans towards Wildcard and asks : 
    Cheif: Son, are you ok ? Have you been taking your medication properly ? You know who I am right ? 
    """
    @everywhere -> require('./medication')(story)
    @everywhere ->
      "yes" : ->
        @text """
        Chief: Good ! Don't scare me like that.... Let's solve this case then !
        """
      "no" : ->
        @text """
        Chief looks even more shoked. 
        Chief: I know you since you were kid. How can you not know my name ? 
               I think you should take your medication now. It's not good if you skip it. 
        Wildcard usually takes it with his morning coffee. But on this ocassion he had to skip breakfast to respond 
        to the urgent crime call.
        """
        @everywhere ->
          "chief's name/what is your name chief": ->
            @text """
            Chief : Willy, take your medication please .
            """
  death: ->
    @text """
    The chief stares at the detective's body in dread
    Chief : "Wildcard's dead ..."
    {Type respawn to start from begining}
    """
    @everywhere ->
      'restart/respawn/start/new': story.intro
      'default': story.death
}

module.exports = story