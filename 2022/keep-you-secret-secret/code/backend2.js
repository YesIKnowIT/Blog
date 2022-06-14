const express = require('express');
const app = express();

// Setup some constants from the environement:
const port = process.env.MY_PORT || 3000;
const api_key = process.env.MY_API_KEY;

const frontend_config=`
var api_key='${api_key}';
`;

app.use('/', express.static('src/'));

app.get('/config.js', (req, res) => {
  res.send(frontend_config);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
