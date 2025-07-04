include <../../modules/math_tricks.scad>; 
include <../../modules/handles.scad>; 

$fn = 128;

height = 6;
detail_height = 2;
disc_height = 0;
center_offset = 15.8; // [ 12 : 0.001 : 20 ]
lw = 2; // [ 0 : 0.01 : 4 ]

wand();

module wand(){
    grip_wand( height, detail_height, disc_height, center_offset, lw );
    arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw );
}



module arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw ){
    // tip details
    translate([0,0,height/2 - practically_zero])
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

    translate([0,0,-height/2 - detail_height + practically_zero])
    linear_extrude(detail_height){
        translate([280, center_offset])
        rotate(45){
            square([9,lw], center = true);
            rotate(90)
            square([9,lw], center = true);
        }
    }
}