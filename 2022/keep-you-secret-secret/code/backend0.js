const express = require('express');
const app = express();
const config = require('./config.js');

if (config.api_key === undefined) {
  throw new Error('The API key is undefined');
}


app.get('/', (req, res) => {
  console.log(`Don't tell anyone, but our API key is ${config.api_key}\n`);
  res.send('OK\n');
});

app.listen(config.port, () => {
  console.log(`Example app listening on port ${config.port}`);
});
