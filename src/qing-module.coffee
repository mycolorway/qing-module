class QingModule

  # Add properties to {QingModule} class.
  #
  # @param [Object] obj The properties of {obj} will be copied to {QingModule}
  #                     , except property named `extended`, which is a function
  #                     that will be called after copy operation.
  @extend: (obj) ->
    unless obj and typeof obj == 'object'
      throw new Error('QingModule.extend: param should be an object')

    for key, val of obj when key not in ['included', 'extended']
      @[key] = val

    obj.extended?.call(@)
    @

  # Add properties to instance of {QingModule} class.
  #
  # @param [Hash] obj The properties of {obj} will be copied to prototype of
  #                   {QingModule}, except property named `included`, which is
  #                   a function that will be called after copy operation.
  @include: (obj) ->
    unless obj and typeof obj == 'object'
      throw new Error('QingModule.include: param should be an object')

    for key, val of obj when key not in ['included', 'extended']
      @::[key] = val

    obj.included?.call(@)
    @

  # @property [Hash] The registered plugins.
  @plugins: {}

  # Register plugin for {QingModule}
  #
  # @param [String] name The name of plugin.
  # @param [Function] cls The class of plugin.
  #
  @plugin: (name, cls) ->
    unless name and typeof name == 'string'
      throw new Error 'QingModule.plugin: first param should be a string'

    unless typeof cls == 'function'
      throw new Error 'QingModule.plugin: second param should be a class'

    @plugins[name] = cls
    @

  @opts:
    plugins: []

  plugins: {}

  # Create a new instance of {QingModule}
  #
  # @param [Hash] opts The options for initialization.
  #
  # @return The new instance.
  constructor: (opts) ->
    @opts = $.extend {}, QingModule.opts, opts

    @opts.plugins.forEach (name) =>
      @plugins[name] = new QingModule.plugins[name](@)

  on: (args...) ->
    $(@).on args...

  off: (args...) ->
    $(@).off args...

  trigger: (args...) ->
    $(@).triggerHandler(args...)

  one: (args...) ->
    $(@).one args...

module.exports = QingModule
