

bank_height = 20; // [0 : 50]
bank_radius = 50; // [0 : 50]

chip_radius = 12; // [0 : 30]
chip_offset = 30; // [0 : 30]
chip_floor = 3;   // [0 : 30]

round_over = 2;
 
ro_enable = false; // [true: false]

function ro(val) = val - (ro_enable ? round_over : 0 )


// minkowski() {
    // sphere(round_over);
    // difference() {
        // color("lime")
        cylinder(
            ro(bank_height) , 
            ro(bank_radius) , 
            ro(bank_radius) 
        );
        
        // for ( theta = [0 : 360/5 : 360]) {
            
        //     color("pink")
        //     rotate(theta)
        //     translate([
        //         chip_offset, 
        //         0, 
        //         ro(chip_floor)
        //     ])
        //     cylinder(
        //         ro(bank_height) , 
        //         ro(chip_radius) , 
        //         ro(chip_radius)  
        //     );
        // }
    // }

    // }


