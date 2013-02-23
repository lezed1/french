var app = require('express').createServer()
, io = require('socket.io').listen(app);

var port = process.env.PORT || 5000;

app.listen(port);

app.get('/', function (req, res) {
    res.sendfile('index.html');
});

io.sockets.on('connection', function (socket) {
    socket.emit('news', { hello: 'world' });
    socket.broadcast.emit('news', { hello: 'world' });
    socket.on('my other event', function (data) {
	console.log(data);
    });
});

io.configure(function () { 
    io.set("transports", ["xhr-polling"]); 
    io.set("polling duration", 10); 
});