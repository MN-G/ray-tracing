const std = @import("std");
const image_width: usize = 256;
const image_height: usize = 256;

pub fn main() !void {
    var out_buf: [1024]u8 = undefined;
    var writer = std.fs.File.stdout().writer(&out_buf);
    const stdout = &writer.interface;

    try stdout.print("P3\n{d} {d}\n255\n", .{ image_width, image_height });

    for (0..image_height) |height| {
        for (0..image_width) |width| {
            const r: f64 = @as(f64, @floatFromInt(width)) / @as(f64, @floatFromInt(image_width - 1));
            const g: f64 = @as(f64, @floatFromInt(height)) / @as(f64, @floatFromInt(image_height - 1));
            const b: f64 = 0.0;

            const ir: u64 = @intFromFloat(255.999 * r);
            const ig: u64 = @intFromFloat(255.999 * g);
            const ib: u64 = @intFromFloat(255.999 * b);

            try stdout.print("{d} {d} {d} \n", .{ ir, ig, ib });
        }
    }

    try stdout.flush();
}
