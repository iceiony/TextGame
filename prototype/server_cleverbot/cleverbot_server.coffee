http = require 'http'
Cleverbot = require 'cleverbot-node'

bots = {};

http.createServer((req, res)->
    if not bots[req.connection.remoteAddress]
        bots[req.connection.remoteAddress] = new Cleverbot();
        setTimeout(->
            delete bots[req.connection.remoteAddress]
        , 1000 * 60 * 20 )

    postData = ""
    req.on('data', (data)->
        postData += data.toString()
    )
    res.writeHead(200,
        {
            'Access-Control-Allow-Origin': 'http://188.226.234.126'
            'Access-Control-Allow-Methods': 'POST'
            'Access-Control-Allow-Credentials': 'true'
            'Access-Control-Allow-Headers': 'Content-Type,X-Request-With', 'Content-Type': "text/html"
        });

    req.on('end', ()->
        bot = bots[req.connection.remoteAddress]

        if not bot 
            res.write('Huh ?')
            res.end()
        else 
            bot.write(postData,(cleverbot_response)->
                res.write(cleverbot_response.message)
                res.end()
            )
            
    )
).listen(9030)


console.log("started")