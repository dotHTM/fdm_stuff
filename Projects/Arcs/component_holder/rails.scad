$fn = 30;

sqrt2 = sqrt(2);

module rail_profile(vector, wall_depth){
    intersection() {
        translate([- wall_depth, - vector.y/2 ])
        square( [vector.x , vector.y] );

        union() {
            translate([-vector.x/2, 0])
            square( vector , center = true);
            scale(vector)
            rotate(45)
            square( sqrt2/2 * [1, 1], center=true);
        }
    }
}

module rail(vector, wall_depth, length){
    rotate([90,0,90])
    linear_extrude(length)
    rail_profile(vector, wall_depth = 0 );
    rail_endcap(vector, wall_depth = wall_depth);
}

module rail_endcap(vector, wall_depth){
    // intersection() {
    #
    
      cube([vector.x, 1, vector.y]);
    
    rotate_extrude()
    rail_profile(vector, wall_depth = 0 );
    // }
}


rail([4, 2], 1, 10);