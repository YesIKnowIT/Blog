const test_messages = [
  "Sylvain's test string A",
  "Sylvain's test string B",
  "Sylvain's test string C",
  "Sylvain's test string D",
];

// (1) Load the rogue1 module
const { asParagraph } = require("./rogue1");

// (2) Create the worker process
const { fork } = require('child_process');
const worker = fork(`${__dirname}/worker-async`);

// (3) Keep track of the number of pending messages
let pending = 4;

// (4) Install a listener for the worker's responses
worker.on('message', ([id, what, result]) => {
  console.log("parent receiving", [id, what, result]);

  if (what === 'done') {
    console.log('parent processing result for message', id);
    console.log("parent", `<div>Inserted: ${asParagraph(test_messages[id])}</div>`);
  }
  else if (what === "error") {
    console.log('parent processing worker error for message', id);
    console.log("parent", `<div>Cannot insert: ${asParagraph(test_messages[id])}</div>`);
  }
  else {
    throw new Error(`Unknown message [${id}, ${what}]`);
  }

  pending -= 1;
  if (pending == 0) {
    console.log("parent terminating worker");
    worker.disconnect();
  }
});

// (5) Send a bunch of mesages to the worker process
for(let idx in test_messages) {
  const message = [idx, test_messages[idx]];
  console.log("parent sending message", message);
  worker.send([idx, test_messages[idx]]);
}

