http = require 'http'

connectionOptions = {
#  host:"188.226.234.126"
  host:"127.0.0.1"
  port: 9032
  method: "POST"
  path: "/"
}

sessionId = Math.round(Math.random() * 10000 ).toString()

module.exports.record = (data)->
  data = sessionId+"\n"+data
  try
    req = http.request(connectionOptions,(res)->
      res.on("data",(data)->
      )
    )
    req.on('error',(err)->
#      console.log(err)
      #meh something went wrong, server may not be up 
    )
    req.write(data)
    req.end()
  catch 
    #meh , something went wrong , server is not up may be 