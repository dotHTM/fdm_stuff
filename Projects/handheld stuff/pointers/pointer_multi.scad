include <../../modules/math_tricks.scad>; 
include <../../modules/t_slots.scad>; 
include <../../modules/handles.scad>; 

use <pointer.scad>; 

$fn = 18;

t_round = .5;
t_width = 4;
t_thick = 2;
t_neck = 8;
t_neck_thick = 2;
t_height= 100;

part_window = 1000;
interface_angle = 45;


height = 6;
detail_height = 2;
disc_height = 0;
center_offset = 15.8; // [ 12 : 0.001 : 20 ]
lw = 2; // [ 0 : 0.01 : 4 ]



intersection() {
    translate([-260, - center_offset, height ])
    wand( height, detail_height, disc_height, center_offset, lw );


    color("red")
    linear_extrude(part_window)
    t_slot_slice(true, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height);
}

translate([0,20, 0])
intersection() {
    translate([-160, - center_offset, height ])
    union(){
        wand( height, detail_height, disc_height, center_offset, lw );
        arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw );
    }
    
    color("blue")
    linear_extrude(part_window)
    t_slot_slice(false, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height);

}

translate([0,40, 0])
intersection() {
    translate([-260, - center_offset, height ])
    union(){
        wand( height, detail_height, disc_height, center_offset, lw );
        arrow_and_x_tips( height ,  detail_height ,  disc_height, center_offset, lw );
    }
    
    color("blue")
    linear_extrude(part_window)
    t_slot_slice(false, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height);

}


