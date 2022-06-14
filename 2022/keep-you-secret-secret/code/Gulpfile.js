const { src, dest, parallel } = require("gulp");
const babel = require('gulp-babel');
const { open } = require("fs/promises");

const api_key = process.env.MY_API_KEY;
if (api_key === undefined) {
  throw new Error('The API key is undefined');
}

const local_config=`
var api_key='${api_key}';
`;

function config() {
  return open("./build/config.js", "w")
    .then(fs => { fs.write(local_config); return fs; })
    .then(fs => fs.close());
}

function build() {
  return src("src/*.js")
    .pipe(babel({ presets: ["@babel/preset-env"]}))
    .pipe(dest("./build"));
}

function copy() {
  return src("src/*.html")
    .pipe(dest("./build"));
}

exports.default = parallel(config, build, copy);
