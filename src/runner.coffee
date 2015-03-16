jscheck = require './jsc'

DEFAULT_REPETITIONS = 100

module.exports = class Runner
  constructor: (@parameters) ->

  run: (cb) ->
    {property, skip, repetitions, predicate} = @parameters

    # Classifier is from jscheck, which can be used to group tests,
    # but isn't currently used here.
    classifier = -> ''

    jscheck.resetRandom()

    attachReporter(cb)
      .reps(repetitions ? DEFAULT_REPETITIONS)
      .test('', propertyToJscheckPredicate({predicate, skip}), property, classifier)

attachReporter = (cb) ->
  # Check cb here, because calling null inside processResult
  # doesnt get logged
  if typeof cb isnt 'function' then throw new Error 'cb should be a function'

  # The test finishes in here
  processResult = (result) ->
    if result.fail > 0 or result.lost > 0
      return cb new Error JSON.stringify(result)

    cb()

  reportFailure = (failure) ->
    console.error JSON.stringify failure
    console.error 'Failed', JSON.stringify failure.args, null, 2

  reportLost = (failure) ->
    console.error JSON.stringify failure
    console.error 'Lost', JSON.stringify failure.args, null, 2

  return jscheck.on_result(processResult).on_fail(reportFailure).on_lost(reportLost)

# @method propertyToJscheckPredicate
# @description provides a method with calling syntax compatible with Douglas Crockfords jscheck
# @see http://www.jscheck.org/
#
# @param {Function} predicate Async function which runs the test and checks expectations
propertyToJscheckPredicate = ({predicate, skip}) ->
  (verdict, args) ->
    if skip? and skip args then return verdict true

    try
      predicate args, (err, result) ->
        if err
          console.error err.message

        verdict !err? and (!result? or result)
    catch e
      console.error e.message
      verdict false
