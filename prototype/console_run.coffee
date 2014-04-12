story = require './story'
prompt = require('prompt-input')()

prompt("hello beautiful\n" , (response)->
  console.log "She said #{response} xoxoxox"
)