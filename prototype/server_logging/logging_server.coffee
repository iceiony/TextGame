http = require 'http'
fs = require 'fs'

http.createServer((req, res)->
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
        sessionId = postData.substr(0, postData.indexOf('\n'))[1..4]
        testName = postData.substr(0, postData.indexOf('\n'))[0]
        postData = postData.replace(/.*\n/, '')

        fileName = testName + req.connection.remoteAddress + "." + sessionId
        fs.appendFile(fileName, postData, (err)->
            if(err)
                console.log(err)
            res.setHeader()
            res.write("Ok")
            res.end()
        )
    )
).listen(9032)


console.log("started")