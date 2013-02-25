app = require('express').createServer()
io  = require('socket.io').listen app

port = process.env.PORT || 5000

app.listen port

app.get '/', (req,res) ->
        res.sendfile 'index.html'

io.sockets.on 'connection', (socket) ->
        ip = socket.handshake
        data = {ip: ip}
        socket.emit 'news', data
        socket.broadcast.emit 'news', data

io.configure () ->
        io.set "transports", ["xhr-polling"]
        io.set "polling duration", 10