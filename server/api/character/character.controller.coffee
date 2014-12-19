"use strict"
_ = require("lodash")

handleError = (res, err) ->
  res.send 500, err
  
Character = require("./character.model")

# Get list of characters
exports.index = (req, res) ->
  Character.find (err, characters) ->
    return handleError(res, err) if err
    res.json 200, characters

# Get a single character
exports.show = (req, res) ->
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err) if err
    return res.send(404) unless character
    res.json character

# Creates a new character in the DB.
exports.create = (req, res) ->
  req.body.user = req.user._id
  Character.create req.body, (err, character) ->
    return handleError(res, err) if err
    res.json 201, character

# Updates an existing character in the DB.
exports.update = (req, res) ->
  delete req.body._id if req.body._id
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err) if err
    return res.send(404) unless character
    updated = _.merge(character, req.body)
    updated.save (err) ->
      return handleError(res, err) if err
      res.json 200, character

# Deletes a character from the DB.
exports.destroy = (req, res) ->
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err) if err
    return res.send(404) unless character
    character.remove (err) ->
      return handleError(res, err) if err
      res.send 204

exports.active = (req, res) ->
  Character.findOne {user: req.user._id, active: true}, (err, character) ->
    return handleError(res, err) if err
    return res.send(204) unless character
    res.json 200, character

deactivate = (userId, callback) ->
  Character.update {user: userId}, {active: false}, {multi: true}, callback


exports.activate = (req, res) ->
  userId = req.user._id
  characterId = req.body.id
  deactivate userId, (err) ->
    return handleError(res, err) if err
    Character.update {_id: characterId}, {active: true}, (err) ->
      return handleError(res, err) if err
      res.send(200)

exports.deactivate = (req, res) ->
  userId = req.user._id
  deactivate userId, (err) ->
    res.send(200)
