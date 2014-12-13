###*
Main application routes
###
"use strict"
errors = require("./components/errors")
module.exports = (app) ->
  
  # Insert routes below
  app.use "/api/things", require("./api/thing")
  app.use "/api/users", require("./api/user")
  app.use "/auth", require("./auth")
  
  # All undefined asset or api routes should return a 404
  assets = "/:url(api|auth|components|app|bower_components|assets)/*"
  app.route(assets).get errors[404]
  
  # All other routes should redirect to the index.html
  app.route("/*").get (req, res) ->
    res.sendfile app.get("appPath") + "/index.html"
