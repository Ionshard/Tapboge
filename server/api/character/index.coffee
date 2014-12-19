"use strict"
express = require("express")
controller = require("./character.controller")
auth = require("../../auth/auth.service")
router = express.Router()
router.get "/", auth.hasRole("dev"), controller.index
router.get "/active", auth.hasRole("player"), controller.active
router.put "/active", auth.hasRole("player"), controller.activate
router.delete "/active", auth.hasRole("player"), controller.deactivate
router.get "/:id", controller.show
router.post "/", auth.hasRole("player"), controller.create
router.put "/:id", auth.hasRole("player"), controller.update
router.patch "/:id", auth.hasRole("player"), controller.update
router.delete "/:id", auth.hasRole("player"), controller.destroy
module.exports = router
