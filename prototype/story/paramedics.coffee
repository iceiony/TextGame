loc = require './locations'

module.exports = (story) ->
  ->
    @location loc.next_to_paramedics
    @text """
    Willy walks to the 2 paramedics resting next to their equipment. 1 Male and one female. 
    They don't look particularly enthusiastic and don't actually notice the detective approaching.
    """  