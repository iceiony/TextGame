module.exports.test = (input)->
    return input.trim().length == 0
   
module.exports.analyse = (input)->
    return {
    input: "",
    type: "silence"
    }