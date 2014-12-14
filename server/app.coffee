###*
Main application file
###
"use strict"

express = require("express")
database = require("./config/database")
config = require("./config/environment")

# Setup server
app = express()
server = require("http").createServer(app)
socketio = require("socket.io")(server,
  serveClient: (if (config.env is "production") then false else true)
  path: "/socket.io-client"
)
require("./config/socketio") socketio
require("./config/express") app
require("./routes") app

# Start server
server.listen config.port, config.ip, ->
  console.log "Express server listening on %d, in %s mode",
  config.port,
  app.get("env")

# Expose app
exports = module.exports = app
