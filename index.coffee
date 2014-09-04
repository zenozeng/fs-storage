mkdirp = require 'mkdirp'
rimraf = require 'rimraf'
path = require 'path'
fs = require 'fs'

encode = (str) ->
    # in adhering to RFC 3986
    encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A")

class Storage

    constructor: (@dirname) ->

    getItem: (key) ->
        file = path.join @dirname, encode(key)
        if fs.existsSync file
            fs.readFileSync file, {encoding: 'UTF-8'}
        else
            null

    setItem: (key, value) ->
        mkdirp.sync @dirname
        file = path.join @dirname, encode(key)
        fs.writeFileSync file, value

    removeItem: (key) ->
        file = path.join @dirname, encode(key)
        if fs.existsSync file
            fs.unlinkSync file

    clear: ->
        rimraf.sync @dirname

module.exports = Storage
