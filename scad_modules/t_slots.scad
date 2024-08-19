

module t_slot_slice( positive, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height){

    if (positive){
        union() {
            rotate(interface_angle)
            translate([-part_window/2, 0])
            square(part_window, center = true);

            rotate(-interface_angle)
            translate([-part_window/2, 0])
            square(part_window, center = true);
        }
        t_slot( t_round, t_width, t_thick, t_neck, t_neck_thick, t_height);

    }
    else
    {

        difference() {
            square(2* part_window, center = true);
            t_slot_slice( true, part_window, interface_angle, t_round, t_width, t_thick, t_neck, t_neck_thick, t_height);
        }
    }

}


module t_slot( t_round, t_width, t_thick, t_neck, t_neck_thick, t_height){
    translate([t_neck - 2 * t_round, 0, 0])
    union() {
        minkowski(){
            circle( t_round );
            union(){
                // neck slot
                translate(
                    [ -(t_neck - 2*t_round)/2 + pz, 0, 0 ]
                    )
                square(
                    [ t_neck -  2*t_round, t_neck_thick -  2*t_round ],
                    center = true);
                // T slot
                square( [ t_thick- 2*t_round, t_width- 2*t_round ] ,
                    center = true);
            }
        }

        // inside coners
        difference() {
            translate([ -t_thick/2 , 0, 0])
            square( [ 2 * t_round, t_neck_thick + 2 * t_round ] ,
                center = true);

            // upper corner
            translate([ -t_thick/2 -  t_round, t_neck_thick/2 +  t_round ])
            circle( t_round);

            // lower corner
            translate([ -t_thick/2 -  t_round, -(t_neck_thick/2 +  t_round) ])
            circle( t_round);
        }
    }
}
