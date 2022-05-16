/*
  BAD CODE: DON'T DO THAT!

  A poorly written library creating some pitfalls
  by modifying the prototype of a standard object

  (btw, the author presumably hasn't heard about
  prepared statement either)
*/

// Send a query to some underlying SQL database
function doQuery(query) {
  // In this example we will simple log the query
  return `QUERY: ${query}`;
}
// Escape a string following the SQL rules:
String.prototype.$escape = function() {
  return this.replace(/'/g,"''");
}

// Helper function to quickly add this string to a dictionary
exports.addToDict = function(string) {
  return doQuery(`INSERT INTO DICTIONARY(entry) VALUES ( '${string.$escape()}' );`);
}


