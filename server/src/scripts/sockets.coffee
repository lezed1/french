socket = require 'socket.io'

exports.init = (app) ->
    io = socket.listen app

    io.configure ()->
    	io.set("transports", ["xhr-polling"])
    	io.set 'polling duration', 10

    io.sockets.on 'connection', (socket) ->
        ip = socket.handshake.headers["x-forwarded-for"] || socket.handshake.address.address
        data = {ip: ip}
        socket.emit 'news', data
        socket.broadcast.emit 'news', data