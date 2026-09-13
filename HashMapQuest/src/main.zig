const std = @import("std");
const Io = std.Io;

const HashMapQuest = @import("HashMapQuest");

pub fn main(init: std.process.Init) !void {
    _ = init;
    std.debug.print("HI\n", .{});
}
