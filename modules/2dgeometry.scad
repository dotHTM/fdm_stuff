include <math_tricks.scad>;

module delta(vector){
    intersection()
    {
        size = max(vector);
        translate([0, -size/2])
        square(size);

        scale(vector)
        rotate(45)
        square( sqrt2/2 * [1, 1], center=true);
    }
}

module trapazoid( length, altitude, taper_a = 0, taper_b = 0){
    
    l = pass_positive( length );
    t1 = pass_between(taper_a, 0, l);
    t2 = pass_between( l - taper_b, t1, l);
    
    polygon([
        [ 0,      0 ],
        [ l, 0 ],
        [ t2,     altitude ],
        [ t1,     altitude ],
        ]);
}



module lifted_trapazoid( length, altitude_a, altitude_b, taper_a = 0, taper_b = 0){
    
    l = pass_positive( length );
    t1 = pass_between(taper_a, 0, l);
    t2 = pass_between( l - taper_b, t1, l);
    
    polygon([
        [ 0,      0 ],
        [ 0,      altitude_b ],
        
        [ t1,     altitude_a + altitude_b ],
        [ t2,     altitude_a + altitude_b ],
        
        [ l,      altitude_b ],
        [ l,      0 ],
        ]);
}

