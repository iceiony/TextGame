http = require 'http'
fs = require 'fs'

http.createServer((req, res)->
  postData = ""
  req.on('data', (data)->
    postData += data.toString()
  )
  req.on('end', ()->
    sessionId = postData.substr(0, postData.indexOf('\n'))[1..4]
    testName = postData.substr(0, postData.indexOf('\n'))[0]
    postData = postData.replace(/.*\n/, '')

    fileName = testName + req.connection.remoteAddress + "." + sessionId
    fs.appendFile(fileName, postData, (err)->
      if(err)
        console.log(err)
      res.write("Ok")
      res.end()
    )
  )
).listen(9032)


console.log("started")