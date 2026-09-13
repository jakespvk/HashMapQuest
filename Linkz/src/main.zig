const std = @import("std");
const Io = std.Io;

const Linkz = @import("Linkz");

pub fn main(init: std.process.Init) !void {
    _ = init;
    Linkz.hi();
}
