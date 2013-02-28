#Module dependencies.

express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
sockets = require './scripts/sockets'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 5000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('1dezel')
  app.use express.session()
  app.use app.router
  app.use require('stylus').middleware(__dirname + '/public')
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', ->
  app.use express.errorHandler()


app.get '/', routes.index

server = http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')

sockets.init server