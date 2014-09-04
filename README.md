# fs-storage

localStorage like, fileSystem based storage

## Install

```bash
npm install fs-storage --save
```

## Usage

```javascript
var Storage = require('fs-storage');
var storage = new Storage('./storage/');
storage.setItem('hello', 'world');
var hello = storage.getItem('hello');
storage.removeItem('hello');
storage.clear();
```

## License

MIT
