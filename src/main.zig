const std = @import("std");
const Vect3 = @import("utils/vec3.zig");
const Color = @import("utils/color.zig");
const image_width: usize = 256;
const image_height: usize = 256;

pub fn main() !void {
    var out_buf: [16384]u8 = undefined;
    var writer = std.fs.File.stdout().writer(&out_buf);
    const stdout = &writer.interface;

    try stdout.print("P3\n{d} {d}\n255\n", .{ image_width, image_height });

    // Outer loop: Scanlines (Counting DOWN from top to bottom)
    for (0..image_height) |height| {

        // Progress Bar: Use std.debug.print
        // This writes to stderr, so it won't go into your image_buf or stdout
        std.debug.print("\rScanlines remaining: {d}   ", .{image_height - (height + 1)});

        for (0..image_width) |width| {
            const pixel_color = Vect3.Color.init(
                @as(f64, @floatFromInt(width)) / @as(f64, @floatFromInt(image_width - 1)),
                @as(f64, @floatFromInt(height)) / @as(f64, @floatFromInt(image_height - 1)),
                @as(f64, 0),
            );

            try Color.write_color(stdout, pixel_color);
        }
    }

    try stdout.flush();
    std.debug.print("\nDone.\n", .{});
}
