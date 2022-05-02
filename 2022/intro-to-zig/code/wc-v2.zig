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

// For now, our input is a hard-coded string
const str = "Bonjour les élèves";

pub fn count() !void {
    const stdin = std.io.getStdIn();

    // Count the chracters up to the end of the string
    var done = false;
    var buffer: [1]u8 = undefined;

    while(!done) {
        const nb = try stdin.readAll(&buffer);
        if (nb == 0) {
            done = true;
        }
        else {
            chars += 1;
        }
    }
}

// the main function is the starting point for your program's execution
pub fn main() void {
    count() catch |err| {
        std.debug.print("Error {} while reading file\n", .{ err });
    };

    // call the function `print` of the `std.debug` namespace
    std.debug.print(" {} chars, {} words, {} lines\n", .{ chars, words, lines });
}
