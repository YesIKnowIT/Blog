//
// Compile and run this program by typing the following commands
// in your shell:
//
//      zig build-exe wc-v1.zig
//      ./wc-v1
//

// Import the "std" module and make it available using the `std` namespace
const std = @import("std");

// Few global variables,
// each one declared as a 32-bits unsigned integer
var chars:u32 = 0;
var lines:u32 = 0;

// The main function is the starting point for your program's execution
pub fn main() void {
    // Call the function `print` of the `std.debug` namespace
    std.debug.print(" {} lines, {} chars\n", .{ lines, chars });
}
