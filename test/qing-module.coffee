QingModule = require '../src/qing-module'
expect = chai.expect

describe 'QingModule', ->

  class TestPlugin extends QingModule
    constructor: (@module) ->
      super()
      this.test = true
    start: ->
      this.started = true

  it 'should support custom events', ->
    module = new QingModule()
    callCount = 0
    listener = ->
      callCount += 1

    module.on 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(1)
    module.off 'customEvent'
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(1)

    module.on 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(2)
    module.off 'customEvent', listener
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(2)

    module.one 'customEvent', listener
    module.trigger 'customEvent'
    module.trigger 'customEvent'
    expect(callCount).to.be.equal(3)

  it 'can extend properties', ->
    extendWithWrongArgs = ->
      QingModule.extend 'test'
    expect(extendWithWrongArgs).to.throw(/param should be an object/)

    QingModule.extend
      classProperty: true
    expect(QingModule.classProperty).to.be.equal(true)

  it 'can include prototype properties', ->
    includeWithWrongArgs = ->
      QingModule.include 'test'
    expect(includeWithWrongArgs).to.throw(/param should be an object/)

    QingModule.include
      prototypeProperty: true
    module = new QingModule()
    expect(QingModule.prototype.prototypeProperty).to.be.equal(true)
    expect(module.prototypeProperty).to.be.equal(true)

  it 'can register plugin', ->
    registerWithoutName = ->
      QingModule.plugin()
    expect(registerWithoutName).to.throw(/first param should be a string/)
    expect(QingModule.plugins.testPlugin).to.be.undefined

    registerWithoutClass = ->
      QingModule.plugin('testPlugin')
    expect(registerWithoutClass).to.throw(/second param should be a class/)
    expect(QingModule.plugins.testPlugin).to.be.undefined

    QingModule.plugin 'testPlugin', TestPlugin
    expect(QingModule.plugins.testPlugin).to.be.equal(TestPlugin)

  it 'can create instance with plugin', ->
    QingModule.plugin 'testPlugin', TestPlugin
    module = new QingModule
      plugins: ['testPlugin']

    expect(module.plugins.testPlugin instanceof TestPlugin).to.be.equal(true)
    expect(module.plugins.testPlugin.test).to.be.equal(true)

    module.plugins.testPlugin.start()
    expect(module.plugins.testPlugin.started).to.be.equal(true)

  it 'should let subclasses override default options', ->
    class ModuleA extends QingModule
      @opts:
        name: 'A'
      constructor: (opts) ->
        super()
        $.extend @opts, ModuleA.opts, opts

    class ModuleB extends ModuleA
      @opts:
        name: 'B'
      constructor: (opts) ->
        super()
        $.extend @opts, ModuleB.opts, opts

    moduleB = new ModuleB()
    moduleA = new ModuleA()
    module = new QingModule()
    moduleX = new ModuleB
      name: 'X'

    expect(moduleB.opts.name).to.be.equal('B')
    expect(moduleA.opts.name).to.be.equal('A')
    expect(module.opts.name).to.be.undefined
    expect(moduleX.opts.name).to.be.equal('X')
