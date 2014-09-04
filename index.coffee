mkdirp = require 'mkdirp'
rimraf = require 'ramrif'
path = require 'path'
fs = require 'fs'

escape = (str) ->
    # in adhering to RFC 3986
    encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A")

class Storage

    constructor: (@dirname) ->
        mkdirp.sync @dirname

    getItem: (key) ->
        file = path.join @dirname, escape(key)
        if fs.existsSync file
            fs.readFileSync file
        else
            null

    setItem: (key, value) ->
        file = path.join @dirname, escape(key)
        fs.writeFileSync file, value

    removeItem: (key) ->
        file = path.join @dirname, escape(key)
        fs.unlinkSync file

    clear: -> ramrif.sync @dirname

module.exports = Storage
