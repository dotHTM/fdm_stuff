include <math_tricks.scad>; 




module grip_wand( height ,  detail_height ,  disc_height, center_offset, lw ){
    // body
    color("lime")
    translate([0,center_offset,0])
    intersection() {
        cube([1000, 1000, height ], center = true);
        rotate([0,90,0])
        rotate_extrude()
        intersection() {
            square(1000);
            translate([center_offset, 0])
            rotate(90)
            import("../svg/handle_wand_body.svg", dpi = 300, $fn = 4);
        }
    }
    
    // grips
    color("pink")
    translate([0,center_offset,0])
    intersection() {
        cube([1000, 1000, height + detail_height * 2], center = true);
        rotate([0,90,0])
        rotate_extrude()
        intersection() {
            square(1000);
            translate([center_offset + 2, 0])
            rotate(90)
            import("../svg/handle_wand_grip.svg", dpi = 300);
        }
    }
}

module handle_sword(){
    pommel_ro = 3.5;
    hilt_ro = 7;
    
    scale([1, 1.25, 2])
    x_axis_polygon_revolve([
        [   0,   0 ],
        [   8,   8 + 1],
        [  25,   4 + 1],
        [  85,   4 + 1],
        [ 100,  10 + 1],
        [ 110,  30 + 1],
        [ 110,  30 + 1],
        [ 107,   6 ],
        [ 118,   practically_zero ],
        [ 270,   practically_zero ],
        [ 270,   0 ],
        ]);
    
    
}

module x_axis_polygon_revolve( points ){
 intersection() {
    cube( [ 1000, 1000, 10], center = true);
    scale([1, 1, 1/2])
    rotate( 90 * yv )
    rotate_extrude() {
        rotate(90)
        intersection() {
            square(1000);
            minkowski() {
                circle(2.5);
                translate([5, 0])
                polygon(points);
            }
        }
    }
}
}