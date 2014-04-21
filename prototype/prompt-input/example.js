var prompt = require("./index")();

prompt('Hello. Is it your first time here?', function (answer) {

  console.log('    Answer was %s', answer);

  prompt({ name: '{red}Your name:{reset}', age: '{green}Your age:{reset}' }, function (answers) {

    console.log('    Answers: ', answers);

    process.exit();
  });
});
