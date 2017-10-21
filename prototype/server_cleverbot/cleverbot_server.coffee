http = require 'http'
url = require 'url'
finalhandler = require 'finalhandler'
serveStatic = require 'serve-static'
serve = serveStatic('../WebA', { 'index' : ['index.html'] })

Cleverbot = require 'cleverbot-node'
cleverbot = new Cleverbot();
bots = {};

cleverbot = (req, res)->
    console.log('cleverbot request')
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
            'Access-Control-Allow-Origin': 'http://127.0.0.1'
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
            Cleverbot.prepare () ->
                bot.write(postData, (cleverbot_response)->
                    res.write(cleverbot_response.message)
                    res.end()
                )
            
    )

filesystem = (req, res)->
    done = finalhandler(req, res);
    serve(req, res, done);

http.createServer((req, res)->
    url_path = url.parse(req.url).pathname
    console.log(url_path)
    switch url_path
        when "/cleverbot" then cleverbot(req, res)
        else filesystem(req, res)
).listen(process.env.PORT || 8080)

console.log("started")
