_ = require 'lodash'
RunnerParametersBuilder = require './runnerParametersBuilder'
RunnerBuilder = require './runnerBuilder'

exports.generators = require './generators'

# Execute multiple tests using the generator to generate
# input values, and calling property to run a test with those values.

exports.forAll = do (runnerBuilder = new RunnerBuilder()) ->
  -> runnerBuilder.forAll arguments...

exports.repetitions = do (runnerBuilder = new RunnerBuilder()) ->
  -> runnerBuilder.repetitions arguments...
