const express = require('express');
const app = express();

const axios = require("axios");

// Setup some constants from the environement:
const port = process.env.MY_PORT || 3000;
const api_key = process.env.MY_API_KEY;

app.use('/', express.static('src/'));

app.get('/search/:location', (req, res) => {
  return axios.get('https://maps.googleapis.com/maps/api/place/findplacefromtext/json', {
    params: {
      inputtype: 'textquery',
      fields: 'name,opening_hours',
      input: req.params.location,
      key: api_key,
  }})
    .then((answer) => {
      const candidate = answer.data.candidates[0] || {};
      const opening_hours = candidate.opening_hours || {};
      const open_now = opening_hours.open_now;
      res.json({
        location: req.params.location,
        open_now: open_now,
      })
    });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
