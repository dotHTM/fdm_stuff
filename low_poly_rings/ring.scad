
fn1 = 5; // [5, 60]
fn2 = 10; // [24, 60]
ro_fn = 30;

r1 = 21.4;

round_over = 1 ; 
// round_over = 0.0001 ; 

a1 = 360/fn1;
a2 = 360/fn2;

outscribed_ratio = 1 - cos( a1 / 2 ) ;
inscribed_ratio  = cos( a2 / 2 ) ;

target = 90  ; 

id = (  target  - ( r1 * outscribed_ratio) )/ inscribed_ratio + round_over / 2;
// id =  (target  - ( r1 * outscribed_ratio ))/inscribed_ratio ;


// cylinder(1 , target/2, target/2, $fn= 100);

function move_it(scalar) = scalar * [1, 0, 0];


ratio = 2.11; 




rotate([90])
rotate(90)
rotate([90])
rotate(90)
{
    
rotate([ 0, 90 , 0 ])
rotate(90)
sphere(7+1.1, $fn = 10);

rotate(90)
sonic_ring( r1, ratio, 14.8 );
}

rotate([90])
rotate(90)
{
    
rotate([ 0, 90 , 0 ])
rotate(0)
sonic_ring( r1, ratio, 32.1 );

rotate(90)
sonic_ring( r1, ratio, 48.5 );
}

rotate([ 0, 90 , 0 ])
sonic_ring( r1, ratio, 64 );

rotate(90)
sonic_ring( r1, ratio, 78.8 );

rotate([ 90, 0 , 0 ])
sonic_ring( r1, 1, id );




// translate( move_it( 1.6 * id ) )
// sonic_ring(r1, 2, id );

// translate( move_it( 3.2 * id ) )
// sonic_ring( 2 * r1, 2, id );

// translate( move_it( 5.4 * id ) )
// sonic_ring( 2 * r1, 1, id );

// translate( move_it( 5.4 * id ) )
// sonic_ring( 2 * r1, 1, id );

// translate( move_it( 7.8 * id ) )
// sonic_ring( 2 * r1, 2, id* 1.5);

// translate( move_it( 10.4 * id ) )
// sonic_ring( 2 * r1, 1, id* 1.5);



module sonic_ring( height, hr, inner_diameter ){
    r1 = height / 2 / hr;
    r2 = inner_diameter / 2;

    
    rotate_extrude( $fn = fn2 )
    minkowski() {
        circle(round_over , $fn = ro_fn);
        scale([ 1, height/r1/2 ])
            translate([r1 + r2 ,0 ,0 ])
            rotate(180 + a1/2 )
            circle(r1 - round_over , $fn = fn1);
    }
}