const str = "Sylvain's test string";

// (1) Load the rogue1 module and encode a string an as HTML paragraph element
const { asParagraph } = require("./rogue1");
console.log(`<div>Will insert: ${asParagraph(str)}</div>`);

// (2) Load the rogue2 module and do some stuff
const { addToDict } = require("./rogue2");
console.log(addToDict(str))

// (3) Same instruction as in (1), but DIFFERENT result
console.log(`<div>Inserted: ${asParagraph(str)}</div>`);
