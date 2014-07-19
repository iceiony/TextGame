http = require 'http'
connectionOptions = {
    host: "188.226.234.126"
    port: 9030
    method: "POST"
    path: "/"
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

module.exports.write = (message,callback)->
    try
        req = http.request(connectionOptions, response_handler(callback))
        req.on('error', (err)->
            console.log(err)
        )
        req.write(message)
        req.end()
    catch err
        console.log(err)
    