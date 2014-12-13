"use strict"
should = require("should")
_ = require("lodash")
app = require("../../app")
Character = require("./character.model")

characterData = {
  name: "Test Character"
  active: false
  user: null
}

describe "Character Model", ->
  before (done) ->
    # Clear characters before testing
    Character.remove().exec().then ->
      done()

  afterEach (done) ->
    Character.remove().exec().then ->
      done()

  it "should begin with no characters", (done) ->
    Character.find {}, (err, characters) ->
      characters.should.have.length 0
      done()

  it "should fail when saving a duplicate character", (done) ->
    Character.create characterData, (err, character) ->
      Character.create characterData, (err, characterDup) ->
        should.exist err
        done()

  it "should fail when saving without a user", (done) ->
    Character.create characterData, (err, character) ->
      should.exist err
      done()

  it "should save a character", (done) ->
    id = "000000000000000000000000"
    Character.create _.merge(characterData, {user: id}), (err, character) ->
      should.not.exist(err)
      character.name.should.be.equal("Test Character")
      done()

