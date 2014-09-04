fs = require 'fs'
path = require 'path'

ls = ->
    dir = './storage/helloworld/'
    if fs.existsSync dir
        files = fs.readdirSync dir
        files.forEach (file) ->
            console.log "# #{dir + file}"
            console.log fs.readFileSync(dir + file, {encoding: 'UTF-8'})
    else
        console.log "#{dir} not exists"

test = (fn) ->
    console.log ''
    console.log 'TEST:'
    console.log fn.toString()
    fn()
    ls()

Storage = require '../index'
storage = new Storage './storage/helloworld/'

test ->
    storage.clear()

test ->
    storage.clear()

test ->
    storage.setItem 'hello', 'hello'

test ->
    storage.setItem 'test/!#/world', JSON.stringify([1, 2, 3])

test ->
    storage.removeItem 'test/!#/NOT EXISTS'

test ->
    console.log storage.getItem('test/!#/world')
    console.log storage.getItem('test/!#/NOT EXISTS')
    console.log storage.getItem('hello')

test ->
    storage.removeItem 'test/!#/world'

test ->
    storage.clear()
