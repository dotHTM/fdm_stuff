include <../../modules/math_tricks.scad>;
include <../../modules/handles.scad>;
include <../../modules/icons.scad>;

$fn = 30;

os_wand();

module os_wand() {
    union(){
        handle_sword();
        
        start = 100;
        length = 180;
        straight_length = 20;
        taper_length = 180 - straight_length; 
        
        // alternative wand length
        // scale([1,2,1]){
        //         translate(xv*start)
        //         rotate(yv*90)
        //         cylinder(straight_length, 5, 5);
        //         translate(xv*(straight_length + start))
        //         rotate(yv*90)
        //         cylinder(taper_length, 5, 1.5);
                
        //         }

        translate([275, 0]) {
          scale(2)
          // icon_hand(4, 2);
          icon_arrow(pointing = true, 3, 1);
      }
  }
}


