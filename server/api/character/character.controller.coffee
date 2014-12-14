"use strict"
_ = require("lodash")

handleError = (res, err) ->
  res.send 500, err
  
Character = require("./character.model")

# Get list of characters
exports.index = (req, res) ->
  Character.find (err, characters) ->
    return handleError(res, err)  if err
    res.json 200, characters

  return

# Get a single character
exports.show = (req, res) ->
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err)  if err
    return res.send(404)  unless character
    res.json character

  return

# Creates a new character in the DB.
exports.create = (req, res) ->
  req.body.user = req.user._id
  Character.create req.body, (err, character) ->
    return handleError(res, err)  if err
    res.json 201, character

  return

# Updates an existing character in the DB.
exports.update = (req, res) ->
  delete req.body._id  if req.body._id
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err)  if err
    return res.send(404) unless character
    updated = _.merge(character, req.body)
    updated.save (err) ->
      return handleError(res, err)  if err
      res.json 200, character

    return

  return

# Deletes a character from the DB.
exports.destroy = (req, res) ->
  Character.findById req.params.id, (err, character) ->
    return handleError(res, err) if err
    return res.send(404) unless character
    character.remove (err) ->
      return handleError(res, err) if err
      res.send 204

    return

  return
