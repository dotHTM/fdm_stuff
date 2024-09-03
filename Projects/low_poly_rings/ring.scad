


$fn1 = 5; // [3: 60]
$fn2 = 10; // [10: 60]

height = 10; // [1: 50]

id = 20.6 ; // [0 : .1 : 100]
od_delta = 1 ; // [0 : .1 : 10]

function move_it(scalar) = scalar * [1, 0, 0];



sonic_ring( height, id, od_delta);





module sonic_ring( height, inner_diameter, od_delta, a_offset=0 , $fn1 = $fn1, $fn2 = $fn2){
    // r1 = height / 2 / height_ratio;
    r1 = od_delta;
    r2 = inner_diameter / 2;
    
    a1 = 360/$fn1;
    a2 = 360/$fn2;
    
    outscribed_ratio = 1 - cos( a1 / 2 ) ;
    inscribed_ratio  = cos( a2 / 2 ) ;

    rotate_extrude( $fn = $fn2 )
    minkowski() {
        scale([ 1, height/2/r1 ])
            translate([r1 + r2 ,0 ,0 ])
            rotate(180 + a1/2 + a_offset)
            circle(r1 , $fn = $fn1);
    }
}