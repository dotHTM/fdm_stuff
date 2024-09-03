include <math_tricks.scad>;
include <2dgeometry.scad>;

$fn = 30;




module delta_rail(vector, length, taper_a = 0, taper_b = 0 , wall_extend = 0){
    
    size = max([max(vector) + wall_extend, length]);
    altitude = vector.x/2;
    
    intersection() {
        translate([0,0,-size/2])
        cube(size);
        minkowski() {
            linear_extrude(practically_zero) {
            translate([0, -altitude])
            lifted_trapazoid(length, altitude, wall_extend, taper_a, taper_b);
          }
          rotate([90,0,90])
          linear_extrude(practically_zero) {
            delta(vector);
        }
    }
}
}

