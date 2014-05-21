####
# Checklist of all the thinks i want the game to do 
####

describe('Story node - transitioning', ->
  
  describe('When transitioning with dialog for a single character', ->
    it('Should keep the same location')
    it('Should respond to arbitrary input')
    it('Should respond differently to repeating dialogue')
    it("Should change the character's attitude if dialogue is insulting")
    it("Should be able to keep context on the dialog for follow up dialogue")
    it("Should cause change in location if character leads you somewhere")
  )
  describe('When transitioning with dialog for a multiple characters', ->
    it('Should correctly identify the user it is referring to it by name')
    it("Should prioritise the dialog to go to the last user speaking")
  )

  describe('When transitioning with location', ->
    it("Should change the current location if moving to an entity")
    it("Should change the current location if moving to another character")
    it("Should describe what the character was doing when moving to a character")
    it("Should describe the entity you moved towards")
    it("Should describe the character's reaction if leaving in the middle of a dialogue")
    it("Should allow for arbitrary movement with cardinal points and directions")
  )

  describe('When transitioning with actions on an entity', ->
    it('Should have a reaction from the entity')
    it('Should have a reaction from characters around')
    it('Should change location if the provides mobility')
  )
  
  describe('When transitioning with actions on an characters', ->
    it("Should affect the character's behaviour")
    it("Should affect surrounding character's behaviour")
  )
)
