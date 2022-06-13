const express = require('express');
const app = express();

// Setup some constants from the environement:
const port = process.env.MY_PORT || 3000;
const api_key = process.env.MY_API_KEY;

if (api_key === undefined) {
  throw new Error('The API key is undefined');
}


app.get('/', (req, res) => {
  console.log(`Don't tell anyone, but our API key is ${api_key}\n`);
  res.send('OK\n');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
