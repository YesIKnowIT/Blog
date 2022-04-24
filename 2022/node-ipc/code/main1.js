const str = "Sylvain's test string";

// (1) Load the rogue1 module and encode a string an as HTML paragraph element
const { asParagraph } = require("./rogue1");
console.log("asParagraph(str):", asParagraph(str));

// (2) Load the rogue2 module and do some stuff
const { addToDict } = require("./rogue2");
console.log("addToDict(str):", addToDict(str))

// (3) Same instruction as in (1), but DIFFERENT result
console.log("asParagraph(str):", asParagraph(str));
