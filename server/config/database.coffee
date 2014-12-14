"use strict"
# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or "development"
mongoose = require("mongoose")
config = require("./environment")

# Connect to database
mongoose.connect config.mongo.uri, config.mongo.options

# Populate DB with sample data
require "./seed"  if config.seedDB
