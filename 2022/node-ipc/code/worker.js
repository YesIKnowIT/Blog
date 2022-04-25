// When launched by `child_process.fork()` from the `main` program:
// process.argv[0] is the path to the node executable
// process.argv[1] is the path to this module
// process.argv[2..n] are the command line arguments given at
//   the `child_process.fork()` call site

const str = process.argv[2];

// Load the rogue2 module and do some stuff
const { addToDict } = require("./rogue2");
console.log(addToDict(str))
