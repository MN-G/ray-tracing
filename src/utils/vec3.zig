const std = @import("std");

const Vec3 = struct {
    e: @Vector(3, f64),

    pub fn zero() Vec3 {
        return Vec3{
            .e = .{ 0, 0, 0 },
        };
    }
    pub fn init(e1: f64, e2: f64, e3: f64) Vec3 {
        return Vec3{
            .e = .{ e1, e2, e3 },
        };
    }
    pub fn x(self: Vec3) f64 {
        return self.e[0];
    }
    pub fn y(self: Vec3) f64 {
        return self.e[1];
    }
    pub fn z(self: Vec3) f64 {
        return self.e[2];
    }

    pub fn negate(self: Vec3) Vec3 {
        return Vec3{ .e = -self.e };
    }
    // inplace addition
    pub fn addAssign(self: *Vec3, v: Vec3) void {
        self.e += v.e;
    }
    // in place scarlar multiplication
    pub fn mulAssign(self: *Vec3, s: f64) void {
        self.e *= @splat(s);
    }
    // in place scalar division
    pub fn divAssign(self: *Vec3, s: f64) void {
        self.e /= @splat(s);
    }
    pub fn length(self: Vec3) f64 {
        return std.math.sqrt(self.lenSquared());
    }
    pub fn lengthSquared(self: Vec3) f64 {
        return @reduce(.Add, (self.e * self.e));
    }
    pub fn format(
        self: Vec3,
        comptime _: []const u8,
        _: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("{d} {d} {d}", .{ self.e[0], self.e[1], self.e[2] });
    }
};

pub const Point3 = Vec3;
pub const Color = Vec3;

// vector util functions
pub fn add(v1: Vec3, v2: Vec3) Vec3 {
    return Vec3{ .e = v1.e + v2.e };
}

pub fn minus(v1: Vec3, v2: Vec3) Vec3 {
    return Vec3{ .e = v1.e - v2.e };
}

pub fn mul(v1: Vec3, v2: Vec3) Vec3 {
    return Vec3{ .e = v1.e * v2.e };
}
pub fn scalarMul(v1: Vec3, s: f64) Vec3 {
    return Vec3{ .e = v1 * @as(@Vector(3, f64), @splat(s)) };
}
pub fn scalarDiv(v1: Vec3, s: f64) Vec3 {
    return Vec3{ .e = v1 / @as(@Vector(3, f64), @splat(s)) };
}
pub fn dot(v1: Vec3, v2: Vec3) f64 {
    return @reduce(.Add, v1.e * v2.e);
}
pub fn cross(u: Vec3, v: Vec3) Vec3 {
    return Vec3.init(
        u.e[1] * v.e[2] - u.e[2] * v.e[1],
        u.e[2] * v.e[0] - u.e[0] * v.e[2],
        u.e[0] * v.e[1] - u.e[1] * v.e[0],
    );
}
pub fn unitVector(v: Vec3) Vec3 {
    return scalarDiv(v, v.length());
}
