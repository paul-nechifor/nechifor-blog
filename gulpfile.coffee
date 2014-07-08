gulp = require 'gulp'
{exec} = require 'child_process'
{Generator} = require './generator'

app = do ->
  index = process.argv.indexOf '--app'
  throw 'no-app' unless index >= 0
  json = process.argv[index + 1]
  JSON.parse json

sh = (cmds, cb) ->
  exec cmds, (err, stdout, stderr) ->
    return cb?() unless err
    process.stdout.write stdout + stderr
    throw err

gulp.task 'default', (cb) ->
  sh """
    rm -fr html
    mkdir -p html
  """, ->
    info =
      app: app
    generator = new Generator info, __dirname + '/posts', __dirname + '/html',
        __dirname + '/templates'
    generator.generate cb
