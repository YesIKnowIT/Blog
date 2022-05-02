//
// compile and run this program by typing the following commands
// in your shell:
//
//      zig build-exe wc-v1.zig
//      ./wc-v1
//

// import the "std" module and make it available using the `std` namespace
const std = @import("std");

// few global variables,
// each one declared as a 32-bits unsigned integer
var chars:u32 = 0;
var words:u32 = 0;
var lines:u32 = 0;

// the main function is the starting point for your program's execution
pub fn main() void {
    // call the function `print` of the `std.debug` namespace
    std.debug.print(" {} chars, {} words, {} lines\n", .{ chars, words, lines });
}
