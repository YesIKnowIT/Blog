//
// Compile and run this program by typing the following commands
// in your shell:
//
//      zig build-exe wc-v4.zig
//      ./wc-v4
//

// Import the "std" module and make it available using the `std` namespace
const std = @import("std");

// Few global variables,
// each one declared as a 32-bits unsigned integer
var chars:u32 = 0;
var lines:u32 = 0;

pub fn count() !void {
    const stdin = std.io.getStdIn();

    // Count the chracters up to the end of the string
    var done = false;
    var buffer: [1]u8 = undefined; // A one byte buffer. Is this really efficient?

    // The ! here is the logical `not` operator
    while(!done) {
        // Read enough data to fill the buffer
        // The `try` keyword means: "If there is an error, abort this function and return the error"
        const nb = try stdin.readAll(&buffer);

        // If we can't fill the buffer, that means we have exhausted the input stream
        if (nb == 0) {
            done = true;
        }
        else {
            chars += 1;
        }

        // Uncomment the following three lines to simulate an error
        // when we encounter the X character
        // if (buffer[0] == 'X') {
        //     return error.Unexpected;
        // }
    }
}

// The main function is the starting point for your program's execution
pub fn main() void {
    count() catch |err| {
        std.debug.print("Error {} while reading file\n", .{ err });
    };

    // Call the function `print` of the `std.debug` namespace
    std.debug.print(" {} lines, {} chars\n", .{ lines, chars });
}
