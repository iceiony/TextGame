var keypress = require("keypress");
var iter = require("iter");
var format = require("style-format");
var stdout, stdin;

module.exports = setup;

function setup (options) {
  stdout = options && options.stdout || process.stdout;
  stdin = options && options.stdin || process.stdin;

  keypress(stdin);

  return prompt;
}

function prompt (questions, callback) {
  if (typeof questions == 'string') return ask(questions, callback);

  var answers = {};
  var keys = Object.keys(questions);

  iter(keys.length)
    .done(function () {
      callback(answers);
    })
    .each(function (next, i) {
      ask(questions[keys[i]], function (answer) {
        answers[keys[i]] = answer;
        next();
      });
    });
}

function ask (question, callback) {
  var answer = '';

  stdout.write( format(question) );
  stdin.setEncoding('utf8');
  stdin.resume();
  stdin.on('keypress', onKeyPress);

  function onKeyPress (char, key) {
    if (key && key.ctrl && (key.name == 'c' || key.name == 'd' )) {
      stdin.removeAllListeners('keypress');
      return stdin.pause();
    }

    if (key && ( key.name == 'enter' || key.sequence == '\r\n' )) {
      stdin.removeAllListeners('keypress');
      stdin.pause();
      return callback(answer);
    }
    answer += char;
  };
}
