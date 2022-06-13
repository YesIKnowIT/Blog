const { src, dest, parallel } = require("gulp");
const { open } = require("fs/promises");

const local_config=`
var my_api_key='123$abc';
`;

function config() {
  return open("c.js", "w")
    .then(fs => fs.write(local_config));
}

exports.default = parallel(config);
