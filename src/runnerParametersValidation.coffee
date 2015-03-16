module.exports = class RunnerParametersValidator
  # constructor
  #
  #   @param {runnerFactory, property, skip, predicate, repetitions} parameters
  #
  #   where {function} property    A generator
  #         {function} skip        A function that takes `(args)` as parameters, and returns a true
  #                                if and only if the test should be skipped
  #         {function} predicate   A function taking `(args, cb)` which asserts expectations.
  #         {function} repetitions The number of times the test should be executed
  #
  constructor: (@parameters) ->

  isValid: -> @parameters.property? and @parameters.predicate?

  getValidationError: ->
    if @isValid() then throw new Error 'There is no error.'

    messages = []
    if !@parameters.property? then messages.push 'You must call builder.forAll().'
    if !@parameters.predicate? then messages.push 'You must call builder.predicate().'

    return new Error messages.join(' ')
