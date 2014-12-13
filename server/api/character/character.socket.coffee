###*
Broadcast updates to client when the model changes
###
onSave = (socket, doc, cb) ->
  socket.emit "character:save", doc
  return
onRemove = (socket, doc, cb) ->
  socket.emit "character:remove", doc
  return
"use strict"
Character = require("./character.model")
exports.register = (socket) ->
  Character.schema.post "save", (doc) ->
    onSave socket, doc
    return

  Character.schema.post "remove", (doc) ->
    onRemove socket, doc
    return

  return
