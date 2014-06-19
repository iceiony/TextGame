getFormatFunction = (colour)->
  format = (text)->
    "{#{colour}}#{text}{reset}"
  return format

colourFormat = {
  'Ann': getFormatFunction('magenta')
  'Female': getFormatFunction('magenta')

  'David': getFormatFunction('blue')
  'Male': getFormatFunction('blue')

  'Henry': getFormatFunction('yellow')
  'Stevey': getFormatFunction('green')

  'Mark': getFormatFunction('red')
  'Farmer': getFormatFunction('red')

  'Chief': getFormatFunction('cyan')
  'Officer in charge': getFormatFunction('cyan')
}

applyFormatOnDialog = (line, format)->
  name = if line.indexOf(":") then line.substr(0,line.indexOf(':') + 1) else ""
  line = line.replace(name,"")

  if(line.indexOf(';') >= 0)
    dialog = line.substr(0, line.indexOf(';'))
    naration = line.substr(line.indexOf(';'))
    line = format(dialog) + naration
  else
    line = format(line)

  return name + line

colouriseDialog = (text)->
  lines = text.split('\n')
  useFormat = undefined;

  for index in [0..lines.length-1]
    line = lines[index]
    if(useFormat != undefined && line.indexOf('  ') == 0)
      lines[index] = applyFormatOnDialog(line, useFormat)
    else
      useFormat = undefined
      for character,format of colourFormat
        reg_exp = new RegExp(character+" *:");
        if(reg_exp.test(line)==true)
          lines[index] = applyFormatOnDialog(line,format)
          useFormat = format;
          break;
          
  return lines.join('\n');

module.exports.colourFormat = colourFormat
module.exports.colouriseDialog = colouriseDialog