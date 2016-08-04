gulp = require 'gulp'
build = require 'qing-build'
pkg = require './package.json'

build
  gulp: gulp
  name: pkg.name
  githubOwner: 'mycolorway'
  version: pkg.version
  homepage: pkg.homepage
  umd:
    dependencies:
      cjs: Object.keys(pkg.dependencies)
      global: ['jQuery']
      params: ['$']
  karma:
    dependencies: ['node_modules/jquery/dist/jquery.js'],
