"use strict"
should = require("should")
_ = require("lodash")
User = require("./user.model")
controller = require("./user.controller")

user1 = null
user2 = null

describe "User Controller", ->
  before (done) ->
    # Clear users before testing
    User.remove().exec().then ->
      done()

  afterEach (done) ->
    User.remove().exec().then ->
      done()

  beforeEach (done) ->
    User.create [
      provider: "local"
      email: "email1@test.com"
      password: "password1"
    ,
      provider: "local"
      email: "email2@test.com"
      password: "password2"
    ], (err, _user1, _user2) ->
      throw err if err?
      user1 = _user1
      user2 = _user2
      done()

  describe "index", ->
    it "should list users", (done) ->
      controller.index {}, {
        json: (res, data) ->
          res.should.equal(200)
          data.length.should.equal(2)
          done()
      }

  describe "create", ->
    it "should create a user", (done) ->
      controller.create {
        body: 
          email: "email3@test.com"
          password: "password3"
      }, {
        json: (res, data) ->
          User.count {}, (err, count) ->
            throw err if err
            count.should.be.equal(3)
            done()
      }

    it "should default to a player", (done) ->
      controller.create {
        body: 
          email: "player@test.com"
          password: "password3"
      }, {
        json: (res, data) ->
          User.findOne {email: "player@test.com"}, (err, player) ->
            throw err if err
            player.role.should.equal("player")
            done()
      }

  describe "show", ->
    it "should fetch a single user", (done) ->
      controller.show {
        params: {id: user1._id}
      }, {
        json: (data) ->
          data.email.should.be.eql("email1@test.com")
          done()
      }

  describe "destroy", ->
    it "should delete a user", (done) ->
      controller.destroy {
        params: {id: user1._id}
      }, {
        send: (res) ->
          res.should.equal(204)
          User.count {}, (err, count) ->
            throw err if err
            count.should.equal(1)
            done()
      }

  describe "changePassword", ->
    it "should change the user's password", (done) ->
      controller.changePassword {
        user: user1
        body:
          oldPassword: "password1"
          newPassword: "other password"
      }, {
        send: (res) ->
          res.should.equal(200)
          User.findById user1._id, (err, user) ->
            user.authenticate("other password").should.be.true
            done()
      }

    it "should reject incorrect password", (done) ->
      controller.changePassword {
        user: user1
        body:
          oldPassword: "wrong"
          newPassword: "other password"
      }, {
        send: (res) ->
          res.should.equal(403)
          User.findById user1._id, (err, user) ->
            user.authenticate("password1").should.be.true
            done()
      }

  describe "me", ->
    it "should return the currently authenticated user", (done) ->
      controller.me {
        user: user2 #User filled by Auth middleware
      }, {
        json: (data) ->
          data.email.should.be.equal(user2.email)
          done()
      }