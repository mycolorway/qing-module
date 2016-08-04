# Qing Module

[![Latest Version](https://img.shields.io/npm/v/qing-module.svg)](https://www.npmjs.com/package/qing-module)
[![Build Status](https://img.shields.io/travis/mycolorway/qing-module.svg)](https://travis-ci.org/mycolorway/qing-module)
[![Coveralls](https://img.shields.io/coveralls/mycolorway/qing-module.svg)](https://coveralls.io/github/mycolorway/qing-module)
[![David](https://img.shields.io/david/mycolorway/qing-module.svg)](https://david-dm.org/mycolorway/qing-module)
[![David](https://img.shields.io/david/dev/mycolorway/qing-module.svg)](https://david-dm.org/mycolorway/qing-module#info=devDependencies)
[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/mycolorway/qing-module)

QingModule is a simple base class providing some necessary features to make its subclasses extendable.

## Features

#### Events

QingModule delegate events mothods to jQuery object:

```js
let module = new QingModule();

// bind namespace event
module.on('customEvent.test', function(data) {
  console.log(data);
});
// equivalent to
$(module).on('customEvent.test', function(data) {
  console.log(data);
});

// trigger a namespace event
module.trigger('customEvent.test', 'test');
// equivalent to
$(module).trigger('customEvent.test', 'test');
```

#### Mixins

Add class properties and methods to QingModule:

```js
var testMixins = {
  classProperty: true,
  classMethod: function() {}
};

QingModule.extend(testMixins);
```

Add instance properties and methods to QingModule:

```js
var testMixins = {
  instanceProperty: true,
  instanceMethod: function() {}
};

QingModule.include(testMixins);
```

#### Plugins

Register a plugin on QingModule:

```js
class TestPlugin extends QingModule {
  constructor(module) {
    super()
    this.module = module;
    this.test = true;
  }
}

QingModule.plugin('testPlugin', TestPlugin);
```

Then pass the plugin name to options while creating instance:

```js
let module = new QingModule({
  plugins: ['testPlugin']
});
console.log(module.plugins.testPlugin.test); // true
```

## Installation

Install via npm:

```bash
npm install --save qing-module
```

## Development

Clone repository from github:

```bash
git clone https://github.com/mycolorway/qing-module.git
```

Install npm dependencies:

```bash
npm install
```

Run default gulp task to build project, which will compile source files, run test and watch file changes for you:

```bash
gulp
```

Now, you are ready to go.

## Publish

When you want to publish new version to npm and bower, please make sure all tests have passed, and you need to do these preparations:

* Add release information in `CHANGELOG.md`. The format of markdown contents will matter, because build scripts will get version and release content from the markdown file by regular expression. You can follow the format of the older releases.

* Put your [personal API tokens](https://github.com/blog/1509-personal-api-tokens) in `/.token.json`(listed in `.gitignore`), which is required by the build scripts to request [Github API](https://developer.github.com/v3/) for creating new release:

```json
{
  "github": "[your github personal access token]"
}
```

Now you can run `gulp publish` task, which will do these work for you:

* Get version number from `CHANGELOG.md` and bump it into `package.json` and `bower.json`.
* Get release information from `CHANGELOG.md` and request Github API to create new release.

If everything goes fine, you can see your release at [https://github.com/mycolorway/qing-module/releases](https://github.com/mycolorway/qing-module/releases). At the End you can publish new version to npm with the command:

```bash
npm publish
```

Please be careful with the last step, because you cannot delete or republish a version on npm.
