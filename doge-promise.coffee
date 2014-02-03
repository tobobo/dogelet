RSVP = require('rsvp')

module.exports = (options) ->
  dogecoin = require('node-dogecoin')(options)

  replacedCommands = [
    'getBalance',
    'getAddressesByAccount',
    'getNewAddress',
    'validateAddress',
    'sendFrom',
    'listTransactions',
    'getTransaction'
  ]

  replacedCommands.forEach (command) ->
    tlc = command.toLowerCase()
    dogecoin["#{command}_nopromise"] = dogecoin[command]
    dogecoin[command] = dogecoin[tlc] = (command_args...) ->
      new RSVP.Promise (resolve, reject) ->
        dogecoin["#{command}_nopromise"] command_args..., (error, result) ->
          if error?
            reject error, result
          else
            resolve result

  dogecoin


