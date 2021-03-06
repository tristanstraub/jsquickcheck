randomSeed = require 'random-seed'
jscheck = require 'jscheck'

seededRandom = null

module.exports = jscheck.configure
  random: ->
    seededRandom ?= module.exports.resetRandom()
    seededRandom.random()

module.exports.resetRandom = ->
  seededRandom = randomSeed.create 'http://xkcd.com/221/'
