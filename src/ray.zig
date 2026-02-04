const std = @import("std");
const V3 = @import("utils/vec3.zig");
const Vec3 = V3.Vect3;
const Point3 = V3.Point3;

const Ray = struct {
    orig: Point3,
    dir: Vec3,

    pub fn init(origin: Point3, direction: Vec3) Ray {
        return Ray{ .origin = origin, .dir = direction };
    }

    pub fn getOrigin(self: Ray) Point3 {
        return self.orig;
    }

    pub fn getDir(self: Ray) Vec3 {
        return self.dir;
    }
    pub fn at(self: Ray, t: f64) Vec3 {
        return self.orig.addAssign(self.dir.mulAssign(t));
    }
};
