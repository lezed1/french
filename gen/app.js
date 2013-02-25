// Generated by CoffeeScript 1.4.0
(function() {
  var app, io, port;

  app = require('express').createServer();

  io = require('socket.io').listen(app);

  port = process.env.PORT || 5000;

  app.listen(port);

  app.get('/', function(req, res) {
    return res.sendfile('index.html');
  });

  io.sockets.on('connection', function(socket) {
    var data, ip;
    ip = socket.handshake;
    data = {
      ip: ip
    };
    socket.emit('news', data);
    return socket.broadcast.emit('news', data);
  });

  io.configure(function() {
    io.set("transports", ["xhr-polling"]);
    return io.set("polling duration", 10);
  });

}).call(this);
