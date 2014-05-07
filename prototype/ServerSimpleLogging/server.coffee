http = require 'http'
fs = require 'fs'

http.createServer((req,res)->
  postData = ""
  req.on('data',(data)->
    postData += data.toString()
  )
  req.on('end',()->
    fileName = req.connection.remoteAddress
    fs.appendFile(fileName,postData,(err)->
      if(err)
        console.log(err)
      res.write("Ok")
      res.end()
    )
  )
  
).listen(9032)


console.log("started")