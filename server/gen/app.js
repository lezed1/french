// Generated by CoffeeScript 1.4.0
(function() {
  var app, express, io, port;

  express = require('express');

  app = express.createServer();

  io = require('socket.io').listen(app);

  port = process.env.PORT || 5000;

  app.configure(function() {
    app.set('views', __dirname + '/views');
    return app.set('view engine', 'jade');
  });

  app.configure('development', function() {
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  app.listen(port);

  app.get('/', function(req, res) {
    return res.render('layout', {
      pageTitle: 'Realtime Messaging Test!'
    });
  });

  app.get('/old', function(req, res) {
    return res.sendFile('server/gen/views/client.html');
  });

  io.sockets.on('connection', function(socket) {
    var data, ip;
    ip = socket.handshake.headers["x-forwarded-for"] || socket.handshake.address.address;
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