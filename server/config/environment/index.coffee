"use strict"
path = require("path")
_ = require("lodash")

requiredProcessEnv = (name) ->
  error_msg = "You must set the " + name + " environment variable"
  throw new Error(error_msg) unless process.env[name]
  process.env[name]

# All configurations will extend these options
# ============================================
all =
  env: process.env.NODE_ENV

  # Root path of server
  root: path.normalize(__dirname + "/../../..")

  # Server port
  port: process.env.PORT or 9000

  # Should we populate the DB with sample data?
  seedDB: false

  # Secret for session, you will want to change this
  # and make it an environment variable
  secrets:
    session: "tapboge-secret"


  # List of user roles
  userRoles: [
    "guest"
    "player"
    "dev"
  ]

  # MongoDB connection options
  mongo:
    options:
      db:
        safe: true

  facebook:
    clientID: process.env.FACEBOOK_ID or "id"
    clientSecret: process.env.FACEBOOK_SECRET or "secret"
    callbackURL: (process.env.DOMAIN or "") + "/auth/facebook/callback"

  twitter:
    clientID: process.env.TWITTER_ID or "id"
    clientSecret: process.env.TWITTER_SECRET or "secret"
    callbackURL: (process.env.DOMAIN or "") + "/auth/twitter/callback"

  google:
    clientID: process.env.GOOGLE_ID or "id"
    clientSecret: process.env.GOOGLE_SECRET or "secret"
    callbackURL: (process.env.DOMAIN or "") + "/auth/google/callback"


# Export the config object based on the NODE_ENV
# ==============================================
env_config = require("./" + process.env.NODE_ENV + ".coffee") or {}
module.exports = _.merge(all, env_config)
