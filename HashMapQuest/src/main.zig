const std = @import("std");
const Io = std.Io;

const HashMapQuest = @import("root.zig");

pub fn main(init: std.process.Init) !void {
    std.debug.print("HI\n", .{});
    var map = try HashMapQuest.HashMap.init(init.gpa);
    defer map.deinit(init.gpa);

    try map.add("hi", "hey");
}
