/* 
  BAD CODE: DON'T DO THAT! 
 
  A poorly written library creating some pitfalls 
  by modifying the prototype of a standard object 
*/

// Escape a string for use as text in an HTML document
String.prototype.$escape = function() {
  return this.replace(/[&<>"']/g, function(m) {
    switch (m) {
      case '&': return '&amp;';
      case '<': return '&lt;';
      case '>': return '&gt;';
      case '"': return '&quot;';
      case '\'': return '&#039;';
      default: assert.fail(`Should escape character ${m}`);
    }
  });

}

// Create an HTML paragraph element fron a string
exports.asParagraph = function(str) { return `<p>${str.$escape()}</p>` }

