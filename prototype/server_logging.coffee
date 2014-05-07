http = require 'http'

connectionOptions = {
  host:"188.226.142.52"
#  host:"127.0.0.1"
  port: 9032
  method: "POST"
  path: "/"
}

module.exports.record = (data)->
  try
    req = http.request(connectionOptions,(res)->
      res.on("data",(data)->
      )
    )
    req.on('error',(err)->
      console.log("something went wrong:"+ err.message);
    )
    req.write(data)
    req.end()
  catch 
    #meh , something went wrong , server is not up may be 