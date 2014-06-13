singleSubject = (obj)->
    if (obj.attribute != undefined) then return 
    return "#{@referredAs()} : Tell me about the #{subject} #{characterEntity.referredAs()}."

youSubjectAndVerbAttribute = (obj)->
    if (obj.attribute == undefined) then return
    return 


youSubjectAndNounAttribute = (obj)->
    if (obj.attribute == undefined) then return
    return "#{@referredAs()} : What is your #{attribute} #{characterEntity.referredAs()} ?"
        
module.exports = [
    singleSubject
    youSubjectAndVerbAttribute
    youSubjectAndNounAttribute
]