{exec, spawn} = require 'child_process'
path = require 'path'

option '-b', '--build', 'build the project before run'

colors =
    black : '\x1B[0;30m'
    red : '\x1B[0;31m'
    green : '\x1B[0;32m'
    yellow : '\x1B[0;33m'
    blue : '\x1B[0;34m'
    magenta : '\x1B[0;35m'
    cyan : '\x1B[0;36m'
    grey : '\x1B[0;90m'
    bold:
      bold : '\x1B[0;1m'
      black : '\x1B[0;1;30m'
      red : '\x1B[0;1;31m'
      green : '\x1B[0;1;32m'
      yellow : '\x1B[0;1;33m'
      blue : '\x1B[0;1;34m'
      magenta : '\x1B[0;1;35m'
      cyan : '\x1B[0;1;36m'
      white : '\x1B[0;1;37m'
    reset : '\x1B[0m'

task 'build', 'build project from source', (options) ->
    build () ->
        console.log 'done.'

task 'run', 'run the app', (options) ->
    if options.build?
        build () ->
            run()
    else
        run() 

module =
    coffee: './node_modules/.bin/coffee -co'
    stylus: './node_modules/.bin/stylus -o'
    nib: './node_modules/nib/lib/nib.js'

log =
    reset: colors.reset
    time: colors.grey
    COMPILE:
        name: 'COMPILE'
        color: colors.bold.yellow
    COPY:
        name: 'COPY'
        color: colors.bold.magenta
    CREATE:
        name: 'CREATE'
        color: colors.bold.cyan
    DELETE:
        name: 'DELETE'
        color: colors.bold.red

    print: (action, directory) ->
        out = " " + "#{log.time}" + "#{(new Date).toLocaleTimeString()}" + " - " + "#{action.color}#{action.name}#{log.reset}" + " #{directory}"
        console.log out

onError = (err)->
  if err
    process.stdout.write "#{colors.red}#{err.stack}#{colors.reset}\n"
    process.exit -1

run = () ->
    process = spawn 'node', ['gen/app.js']
    process.stdout.setEncoding('utf8')
    process.stdout.on 'data', (data) ->
        console.log data
    process.stderr.setEncoding('utf8')
    process.stderr.on 'data', (data) ->
        console.log data

clean = (callback) ->
    # cleaning  gen folder
    exec "rm -rf '#{'gen'}'", (err, stdout, stderr) ->
        onError err
        log.print log.DELETE, "gen"
        callback()

build = (callback) ->

    clean () ->
        # create gen directory
        exec "mkdir -p '#{'gen'}'", (err) ->
            onError err 

            # generate  javascript
            exec "#{module.coffee} 'gen' 'src'", (err, stdout, stderr) ->
                    onError err
                    log.print log.COMPILE, 'gen/'
                    callback()