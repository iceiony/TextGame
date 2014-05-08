http = require 'http'
fs = require 'fs'

http.createServer((req, res)->
  postData = ""
  req.on('data', (data)->
    postData += data.toString()
  )
  req.on('end', ()->
    sessionId = postData.substr(0, postData.indexOf('\n'))
    postData = postData.replace(sessionId + '\n', '')

    fileName = req.connection.remoteAddress + "." + sessionId
    fs.appendFile(fileName, postData, (err)->
      if(err)
        console.log(err)
      res.write("Ok")
      res.end()
    )
  )
).listen(9032)


console.log("started")