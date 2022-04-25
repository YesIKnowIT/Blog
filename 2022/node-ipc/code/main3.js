// Execute the system's `sleep` command and wait for completion
const { spawnSync } = require('child_process');
function sleep(n) {
  return spawnSync('sleep', [ n ]);
}

const str = "Sylvain's test string";

// (1) Load the rogue1 module and encode a string an as HTML paragraph element
const { asParagraph } = require("./rogue1");
console.log(`<div>Will insert: ${asParagraph(str)}</div>`);
sleep(1);

// (2) Load the rogue2 module in a worker process
const { fork } = require('child_process');
fork(`${__dirname}/worker`, [ str ]);
sleep(1);

// (3) Same instruction as in (1), now SAME result
console.log(`<div>Inserted: ${asParagraph(str)}</div>`);
sleep(1);
