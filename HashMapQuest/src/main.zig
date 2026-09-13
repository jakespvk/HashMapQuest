const std = @import("std");
const Io = std.Io;

// since my zls version is behind (0.16.0, to 0.17 master version of Zig lang),
// importing the module properly doesn't give proper intellisense and highlighting
// ... at least ... I assume this is why
// anyways, leaving it like this for now isn't gonna hurt anyone
const HashMapQuest = @import("root.zig");

pub fn main(init: std.process.Init) !void {
    std.debug.print("HI\n", .{});
    var map = try HashMapQuest.HashMap.init(init.gpa);
    defer map.deinit(init.gpa);

    try map.add("hi", "hey");

    const keys = try map.keys(init.gpa);
    defer init.gpa.free(keys);

    for (keys) |key| {
        std.debug.print("key: {s}\n", .{key});
    }
}
