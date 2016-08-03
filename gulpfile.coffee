gulp = require 'gulp'
compile = require './build/compile.coffee'
test = require './build/test.coffee'
publish = require './build/publish.coffee'
coffeelint = require './build/helpers/coffeelint.coffee'

lint = ->
  gulp.src 'build/**/*.coffee'
    .pipe coffeelint()

gulp.task 'default', gulp.series lint, compile, test
