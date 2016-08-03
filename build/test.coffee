gulp = require 'gulp'
karma = require 'karma'
fs = require 'fs'
handleError = require './helpers/error'
compile = require './compile'

test = (done) ->
  server = new karma.Server
    configFile: "#{process.cwd()}/karma.coffee"
  , (code) ->
    fs.unlinkSync 'test/coverage-init.js'
    if code != 0
      handleError "karma exit with code: #{code}"
    done()

  server.start()

gulp.task 'test', gulp.series test, (done) ->
  gulp.watch 'src/**/*.coffee', gulp.series compile.coffee, test
  gulp.watch 'src/**/*.scss', compile.sass
  gulp.watch 'test/**/*.coffee', test

  done()

module.exports = test
