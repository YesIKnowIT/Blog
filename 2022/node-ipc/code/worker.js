const str = process.argv[1];

// (2) Load the rogue2 module and do some stuff
const { addToDict } = require("./rogue2");
console.log("addToDict(str):", addToDict(str))
