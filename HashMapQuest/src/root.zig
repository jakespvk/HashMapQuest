const std = @import("std");
const Io = std.Io;

pub const HashMap = struct {
    items: [][]const u8,

    pub fn init(allocator: std.mem.Allocator) !HashMap {
        return .{ .items = try allocator.alloc([]const u8, 25) };
    }

    pub fn add(this: *HashMap, key: []const u8, value: []const u8) !void {
        const hash_key = try createHashKey(key);

        if (this.items.len >= hash_key and !std.mem.eql(u8, this.items[hash_key], "")) {
            this.items[hash_key] = value;
            return;
        }

        return error.ArrayLengthSlashHashingFunction;
    }

    fn createHashKey(key: []const u8) !usize {
        return key.len;
    }

    pub fn keys(this: *HashMap, allocator: std.mem.Allocator) ![][]const u8 {
        const output = [this.items.len][]const u8{};
        for (this.items, 0..) |item, i| {
            output[i] = item.key;
        }
        return try allocator.dupe([]const u8, output);
    }

    pub fn deinit(this: *HashMap, allocator: std.mem.Allocator) void {
        allocator.free(this.items);
    }
};
