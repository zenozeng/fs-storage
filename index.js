(function() {
  var Storage, escape, fs, mkdirp, path, rimraf;

  mkdirp = require('mkdirp');

  rimraf = require('ramrif');

  path = require('path');

  fs = require('fs');

  escape = function(str) {
    return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
  };

  Storage = (function() {
    function Storage(dirname) {
      this.dirname = dirname;
      mkdirp.sync(this.dirname);
    }

    Storage.prototype.getItem = function(key) {
      var file;
      file = path.join(this.dirname, escape(key));
      if (fs.existsSync(file)) {
        return fs.readFileSync(file);
      } else {
        return null;
      }
    };

    Storage.prototype.setItem = function(key, value) {
      var file;
      file = path.join(this.dirname, escape(key));
      return fs.writeFileSync(file, value);
    };

    Storage.prototype.removeItem = function(key) {
      var file;
      file = path.join(this.dirname, escape(key));
      return fs.unlinkSync(file);
    };

    Storage.prototype.clear = function() {
      return ramrif.sync(this.dirname);
    };

    return Storage;

  })();

  module.exports = Storage;

}).call(this);
