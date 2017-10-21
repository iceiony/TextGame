http = require 'http'
connectionOptions = {
    host: "quiet-river-76351.herokuapp.com"
    port: 80
    method: "POST"
    path: "/cleverbot"
}

response_handler = (callback)->
    return (res)->
        response_message = ""
        res.on("data", (data)->
            response_message += data.toString();
        )
        res.on('end', ->
            callback({message:response_message})
        )

module.exports.write = (message, callback)->
    try
        req = http.request(connectionOptions, response_handler(callback))
        req.on('error', (err)->
            console.log(err)
        )
        req.write(message)
        req.end()
    catch err
        console.log(err)
    
