/**
 * qing-module v3.0.3
 * http://mycolorway.github.io/qing-module
 *
 * Copyright Mycolorway Design
 * Released under the MIT license
 * http://mycolorway.github.io/qing-module/license.html
 *
 * Date: 2016-08-3
 */
;(function(root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'));
  } else {
    root.QingModule = factory(root.jQuery);
  }
}(this, function ($) {
var define, module, exports;
var b = require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"qing-module":[function(require,module,exports){
var QingModule,
  slice = [].slice;

QingModule = (function() {
  QingModule.extend = function(obj) {
    var key, ref, val;
    if (!(obj && typeof obj === 'object')) {
      throw new Error('QingModule.extend: param should be an object');
    }
    for (key in obj) {
      val = obj[key];
      if (key !== 'included' && key !== 'extended') {
        this[key] = val;
      }
    }
    if ((ref = obj.extended) != null) {
      ref.call(this);
    }
    return this;
  };

  QingModule.include = function(obj) {
    var key, ref, val;
    if (!(obj && typeof obj === 'object')) {
      throw new Error('QingModule.include: param should be an object');
    }
    for (key in obj) {
      val = obj[key];
      if (key !== 'included' && key !== 'extended') {
        this.prototype[key] = val;
      }
    }
    if ((ref = obj.included) != null) {
      ref.call(this);
    }
    return this;
  };

  QingModule.plugins = {};

  QingModule.plugin = function(name, cls) {
    if (!(name && typeof name === 'string')) {
      throw new Error('QingModule.plugin: first param should be a string');
    }
    if (typeof cls !== 'function') {
      throw new Error('QingModule.plugin: second param should be a class');
    }
    this.plugins[name] = cls;
    return this;
  };

  QingModule.opts = {
    plugins: []
  };

  QingModule.prototype.plugins = {};

  function QingModule(opts) {
    this.opts = $.extend({}, QingModule.opts, opts);
    this.opts.plugins.forEach((function(_this) {
      return function(name) {
        return _this.plugins[name] = new QingModule.plugins[name](_this);
      };
    })(this));
  }

  QingModule.prototype.on = function() {
    var args, ref;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return (ref = $(this)).on.apply(ref, args);
  };

  QingModule.prototype.off = function() {
    var args, ref;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return (ref = $(this)).off.apply(ref, args);
  };

  QingModule.prototype.trigger = function() {
    var args, ref;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return (ref = $(this)).triggerHandler.apply(ref, args);
  };

  QingModule.prototype.one = function() {
    var args, ref;
    args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
    return (ref = $(this)).one.apply(ref, args);
  };

  return QingModule;

})();

module.exports = QingModule;

},{}]},{},[]);

return b('qing-module');
}));
