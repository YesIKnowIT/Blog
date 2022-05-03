//
// Compile and run this program by typing the following commands
// in your shell:
//
//      zig build-exe wc-v2.zig
//      ./wc-v2
//

// Import the "std" module and make it available using the `std` namespace
const std = @import("std");

// Few global variables,
// each one declared as a 32-bits unsigned integer
var chars:u32 = 0;
var lines:u32 = 0;

pub fn count() !void {
    const stdin = std.io.getStdIn();

    var buffer: [256]u8 = undefined; // A 256-bytes buffer

    // Read enough data to fill the buffer
    // The `try` keyword means: "If there is an error, abort this function and return the error"
    const nb = try stdin.readAll(&buffer);

    // Simulate an error when the buffer starts by an 'X'
    if (buffer[0] == 'X') {
        return error.Unexpected;
    }

    std.debug.print(" {} byte(s) read\n", .{ nb });
}

// The main function is the starting point for your program's execution
pub fn main() void {
    count() catch |err| {
        std.debug.print("Error {} while reading file\n", .{ err });
    };

    // Call the function `print` of the `std.debug` namespace
    std.debug.print(" {} lines, {} chars\n", .{ lines, chars });
}
