(function() {
  var Storage, encode, fs, mkdirp, path, rimraf;

  mkdirp = require('mkdirp');

  rimraf = require('rimraf');

  path = require('path');

  fs = require('fs');

  encode = function(str) {
    return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
  };

  Storage = (function() {
    function Storage(dirname) {
      this.dirname = dirname;
    }

    Storage.prototype.getItem = function(key) {
      var file;
      file = path.join(this.dirname, encode(key));
      if (fs.existsSync(file)) {
        return fs.readFileSync(file, {
          encoding: 'UTF-8'
        });
      } else {
        return null;
      }
    };

    Storage.prototype.setItem = function(key, value) {
      var file;
      mkdirp.sync(this.dirname);
      file = path.join(this.dirname, encode(key));
      return fs.writeFileSync(file, value);
    };

    Storage.prototype.removeItem = function(key) {
      var file;
      file = path.join(this.dirname, encode(key));
      if (fs.existsSync(file)) {
        return fs.unlinkSync(file);
      }
    };

    Storage.prototype.clear = function() {
      return rimraf.sync(this.dirname);
    };

    return Storage;

  })();

  module.exports = Storage;

}).call(this);
