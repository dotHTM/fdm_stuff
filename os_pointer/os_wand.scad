include <../modules/math_tricks.scad>;
$fn = 30;

center_height = 4; 
outline_height = 2; 

build();

module build() {
    union(){
            handle_sword();
            translate([275, 0]) {
              scale(2)
              // hand_end();
              arrow_end();
          }
    }
}

module hand_end(){
    translate(17/2 * yv)
    rotate(-90)
    icon_load(center_height, outline_height, "hand solid.svg", "hand center.svg");
}
module arrow_end(){
    translate((7.25) * yv)
    rotate( atan2(-16,-8) )
    icon_load(center_height, outline_height, "arrow solid.svg", "arrow center.svg");
}
module icon_load(center_height, outline_height, center_file_path, outline_file_path){
    translate([0, 0]){
        translate(-outline_height/2 * zv)
        linear_extrude
        (outline_height)
        import(center_file_path,  dpi = 300 );

        translate(-center_height/2 * zv)
        linear_extrude
        (center_height)
        import(outline_file_path,   dpi = 300 );
    }
}




module handle_sword(){
    pommel_ro = 3.5;
    hilt_ro = 7;
    
    scale([1, 1.25, 2])
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
                    polygon([
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
            }
        }
    }
    
}

