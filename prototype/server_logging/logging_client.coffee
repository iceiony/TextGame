http = require 'http'

testSourceName = 'C'
sessionId = Math.round(Math.random() * 10000).toString()
connectionOptions = {
  host: "188.226.234.126"
#  host:"127.0.0.1"
  port: 9032
  method: "POST"
  path: "/"
}

dataQueue = []

_sendNextToServer = ->
  data = dataQueue[0];
  try
    req = http.request(connectionOptions, (res)->
      res.on("data", (data)->
        dataQueue.shift();
        if(dataQueue.length >= 1)
          _sendNextToServer()
      )
    )
    req.on('error', (err)->
      setTimeout(_sendNextToServer, 1000)
      #meh something went wrong, server may not be up 
    )
    req.write(data)
    req.end()
  catch err
    setTimeout(_sendNextToServer, 1000)
  #meh , something went wrong , server is not up may be 
  finally


startTime = new Date()
module.exports.record = (data)->
  setImmediate( ->
    totalTimeInGame = (new Date() - startTime) / ( 1000 * 60 )
    log_data = "#{testSourceName}#{sessionId}\n\n#{data}\n[#{totalTimeInGame}]"
    dataQueue.push(log_data);
    if(dataQueue.length == 1)
        _sendNextToServer()
  )

module.exports.setTestSource = (name)->
  testSourceName = name 