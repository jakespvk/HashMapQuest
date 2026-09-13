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

    fn dehashKey(hash_key: usize) ![]const u8 {
        var out_str: []const u8 = "";
        for (0..hash_key) |_| {
            out_str = out_str ++ "a";
        }
        return out_str;
    }

    pub fn keys(this: *HashMap, allocator: std.mem.Allocator) ![][]const u8 {
        var output: std.ArrayList([]const u8) = .empty;
        for (this.items, 0..) |_, i| {
            const dehash_key = try dehashKey(i);
            try output.append(allocator, dehash_key);
        }

        return try output.toOwnedSlice(allocator);
    }

    pub fn deinit(this: *HashMap, allocator: std.mem.Allocator) void {
        allocator.free(this.items);
    }
};
