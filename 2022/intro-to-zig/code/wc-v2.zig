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

// For now, our input is a hard-coded string
const str = "Bonjour les élèves";

pub fn count() !void {
    const stdin = std.io.getStdIn();

    // Count the chracters up to the end of the string
    var done = false;
    var buffer: [32*1024]u8 = undefined;

    while(!done) {
        // Read enough data to fill the buffer
        // The `try` keyword means: "If there is an error, abort this function and return the error"
        const nb = try stdin.readAll(&buffer);

        // If we can't fill the buffer, that means we have exhausted the input stream
        if (nb < buffer.len) {
            done = true;
        }

        // Iterate over the bytes of the buffer
        for(buffer[0..nb]) |c| {
            chars += 1;

            if (c == '\n') {
                lines += 1;
            }

            // Uncomment the following three lines to simulate an error
            // when we encounter the X character
            // if (c == 'X') {
            //     return error.Unexpected;
            // }
        }
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
