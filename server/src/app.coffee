express = require('express')
app = express.createServer()
io  = require('socket.io').listen app

port = process.env.PORT || 5000

# configuration

app.configure ->
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'

app.configure 'development', ->
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))


app.listen port

app.get '/', (req,res) ->
        res.render 'layout', {pageTitle: 'Realtime Messaging Test!'}

app.get '/old', (req,res) ->
        res.sendFile 'server/gen/views/client.html'

io.sockets.on 'connection', (socket) ->
        ip = socket.handshake.headers["x-forwarded-for"] || socket.handshake.address.address
        data = {ip: ip}
        socket.emit 'news', data
        socket.broadcast.emit 'news', data

io.configure () ->
        io.set "transports", ["xhr-polling"]
        io.set "polling duration", 10