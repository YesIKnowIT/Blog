const str = "Sylvain's test string";

// (1) Load the rogue1 module and encode a string an as HTML paragraph element
const { asParagraph } = require("./rogue1");
console.log("asParagraph(str):", asParagraph(str));

// (2) Load the rogue2 module in a worker process
const { fork } = require('child_process');
fork(`${__dirname}/worker`, [ str ]);

// (3) Same instruction as in (1), now SAME result
console.log("asParagraph(str):", asParagraph(str));
