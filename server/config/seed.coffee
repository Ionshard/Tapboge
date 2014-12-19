###*
Populate DB with sample data on server start
to disable, edit config/environment/index.js, and set `seedDB: false`
###
"use strict"
User = require("../api/user/user.model")
Character = require("../api/character/character.model")

User.find({}).remove ->
  User.create
    provider: "local"
    email: "test@test.com"
    password: "test"
  ,
    provider: "local"
    role: "dev"
    email: "admin@admin.com"
    password: "admin"
  , (err, user, admin)->
    Character.find({}).remove ->
      Character.create
        user: admin._id
        name: "Character 1"
        # active: true
      ,
        user: admin._id
        name: "Character 2"
    , ->
      console.log "finished populating users"
