const std = @import("std");
const Vec3 = @import("../utils/vec3.zig");

pub fn write_color(writer: *std.io.Writer, color: Vec3.Color) !void {
    const r = color.x();
    const g = color.y();
    const b = color.z();

    const rbyte: u64 = @intFromFloat(255.999 * r);
    const gbyte: u64 = @intFromFloat(255.999 * g);
    const bbyte: u64 = @intFromFloat(255.999 * b);

    try writer.print("{d} {d} {d} \n", .{ rbyte, gbyte, bbyte });
}
