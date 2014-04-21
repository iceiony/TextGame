## prompt-input

Prompt user inputs with styling

## Install

```bash
$ npm install prompt-input
```

## Usage

```js
prompt = require('prompt-input')(/* options */)

prompt('What is your name?', function (answer) {
  answer
  // => Whatever user gives
})
```

Options:

* stdin *(default process.stdin)*
* stdout *(default process.stdout)*

### Styling

You can apply [colors and other styles](http://github.com/azer/style-format) on your questions and/or answers:

```js
prompt = require('prompt-input')

prompt('{bold}{yellow}Are you {red}sure?{reset}')
```


### Multiple questions:

```js
prompt({ name: 'Your name:', age: 'Your age:' }, function (answers) {

  answers.name
  // => john

  answers.age
  // => 20

})
```
