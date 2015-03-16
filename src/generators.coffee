jscheck = require './jsc'

dateSpecifier = require './dateSpecifier'

# Available generators. Get more from jscheck as you need them.
module.exports =
  object: jscheck.object.bind(jscheck)
  boolean: jscheck.boolean.bind(jscheck)
  string: jscheck.string.bind(jscheck)
  oneOf: (args...) -> jscheck.one_of args
  literal: jscheck.literal.bind(jscheck)
  integer: jscheck.integer.bind(jscheck)
  date: dateSpecifier
  any: jscheck.any.bind(jscheck)
  array: jscheck.array.bind(jscheck)
