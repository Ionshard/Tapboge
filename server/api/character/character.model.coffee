"use strict"
mongoose = require("mongoose")
Schema = mongoose.Schema
CharacterSchema = new Schema(
  name: {type: String, required: true},
  user: {type: Schema.Types.ObjectId, ref: 'User', required: true}
  active: {type: Boolean, default: false}
)

# Validate name is not taken
CharacterSchema.path("name").validate ((value, respond) ->
  self = this
  @constructor.findOne {name: value}, (err, user) ->
    throw err if err
    if user
      return respond(true)  if self.id is user.id
      return respond(false)
    respond true

), "The specified character name is already in use."

module.exports = mongoose.model("Character", CharacterSchema)
