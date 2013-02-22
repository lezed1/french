var app = require('express')()
, server = require('http').createServer(app)
, io = require('socket.io').listen(server);

var port = process.env.PORT || 5000;

server.listen(port);

app.get('/', function (req, res) {
    res.send('Hello World!');
});

io.sockets.on('connection', function (socket) {
    socket.emit('news', { hello: 'world' });
    socket.on('my other event', function (data) {
	console.log(data);
    });
});

io.configure(function () { 
    io.set("transports", ["xhr-polling"]); 
    io.set("polling duration", 10); 
});