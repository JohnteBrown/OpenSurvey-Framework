require("coffeescript/register");
global.Backbone = require("backbone");
global._ = require("underscore");

const QUnit = require("qunit");
global.QUnit = QUnit;

require("./survey-parser.test");
require("./branching.test");
require("./export.test");

QUnit.start();

QUnit.on("runEnd", (result) => {
  if (result.testCounts.failed > 0) {
    process.exitCode = 1;
  }
});
