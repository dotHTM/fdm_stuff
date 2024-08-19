include <../scad_modules/math_tricks.scad>; 

$fn = 128;

height = 6;
detail_height = 2;
disc_height = 0;
center_offset = 15.8; // [ 12 : 0.001 : 20 ]
lw = 2; // [ 0 : 0.01 : 4 ]

wand( height, detail_height, disc_height, center_offset, lw );
arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw );

module wand( height ,  detail_height ,  disc_height, center_offset, lw ){

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
            import("body.svg", dpi = 300, $fn = 4);
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
            import("outline.svg", dpi = 300);
        }
    }


}


module arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw ){
    
    // tip details
    translate([0,0,height/2 - pz])
    linear_extrude(detail_height) {
        translate([4, 0])
        translate([280, center_offset]) {
            rotate(135){
                square([6,lw]);
                translate([lw,0])
                rotate(90)
                square([6,lw]);
            }
            translate([-12,-lw/2])
            square([12 - sqrt(2)/2 * lw ,lw]);
        }
    }

    translate([0,0,-height/2 - detail_height + pz])
    linear_extrude(detail_height){
        translate([280, center_offset])
        rotate(45){
            square([9,lw], center = true);
            rotate(90)
            square([9,lw], center = true);
        }
    }
}