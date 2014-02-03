RSVP = require('rsvp')

module.exports = (mailer) ->
  mailer.sendMail_old = mailer.sendMail
  mailer.sendMail = (options) ->
    new RSVP.Promise (resolve, reject) ->
      mailer.sendMail_old options, (error, result) ->
        if error?
          reject error, result
        else
          resolve result 
