"use strict"
should = require("should")
_ = require("lodash")
Character = require("./character.model")
controller = require("./character.controller")


id = "000000000000000000000000"
character1 = null
character2 = null

describe "Character Controller", ->
  before (done) ->
    # Clear characters before testing
    Character.remove().exec().then ->
      done()

  afterEach (done) ->
    Character.remove().exec().then ->
      done()

  beforeEach (done) ->
    Character.create [
      name: "Test Character 1"
      user: id
    ,
      name: "Test Character 2"
      user: id
    ], (err, _character1, _character2) ->
      throw err if err?
      character1 = _character1
      character2 = _character2
      done()

  describe "index", ->
    it "should list characters", (done) ->
      controller.index {}, {
        json: (res, data) ->
          res.should.equal(200)
          data.length.should.equal(2)
          done()
      }

  describe "show", ->
    it "should fetch a single character", (done) ->
      controller.show {
        params: {id: character1._id}
      }, {
        json: (data) ->
          data.name.should.be.eql("Test Character 1")
          done()
      }

  describe "create", ->
    it "should create a character", (done) ->
      controller.create {
        user: {_id: id}
        body: {name: "Controller Character"}
      }, {
        json: (res, data) ->
          res.should.be.equal(201)
          data.name.should.be.eql("Controller Character")
          Character.count {}, (err, count) ->
            throw err if err
            count.should.be.equal(3)
            done()
      }

    it "should associate with the authenticated user", (done) ->
      controller.create {
        user: {_id: id}
        body: {name: "User Character"}
      }, {
        json: (res, data) ->
          data.user.toString().should.eql(id)
          done()
      }

  describe "update", ->
    it "should update an existing character", (done) ->
      controller.update {
        params: {id: character1._id}
        body: {name: "Update Character"}
      }, {
        json: (res, data) ->
          res.should.equal(200)
          data.name.should.eql("Update Character")
          done()
      }

  describe "destroy", ->
    it "should delete a character", (done) ->
      controller.destroy {
        params: {id: character1._id}
      }, {
        send: (res) ->
          res.should.equal(204)
          Character.count {}, (err, count) ->
            throw err if err
            count.should.equal(1)
            done()
      }