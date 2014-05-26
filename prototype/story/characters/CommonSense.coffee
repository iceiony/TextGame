class CommonSense
    constructor:(subject)->
        @subject = subject
    
    interpret: (message)->
        @subject.emit('greeted');

module.exports = CommonSense
