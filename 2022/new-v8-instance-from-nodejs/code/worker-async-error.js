// Used to simulate some processing delay
function randomTimeout(fct) {
  const n = Math.floor(Math.random()*3000 + 1000); // random delay between 1s and 4s
  return setTimeout(fct, n);
}

const { addToDict } = require("./rogue2");

// (1) Handle messages coming from the parent process
// NodeJS handle serialization-deserialization for you
// behing the scene to send data from one V8 instance
// to another one
process.on('message', ([id, str]) => {
  console.log("worker receiving message", [id, str]);

  randomTimeout(() => {
    try {
      // Simulate an error while processing the message with id 2
      if (id == 2) {
        throw new Error("worker error");
      }

      const result = addToDict(str);
      console.log("worker done processing message", id);

      // send the result of this request to the parent process
      process.send([id, 'done', result]);
    }
    catch(err) {
      // Oups: problem. Report error to the parent process
      console.log("worker raising error for message", id, err);
      process.send([id, 'error', err.toString()]);
    }
  });
});

// (2) Graceful termination uppon parent process request
process.on('exit', () => {
  console.log("worker exiting");
});
