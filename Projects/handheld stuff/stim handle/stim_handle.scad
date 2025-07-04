// Pain Stim Handle Fidget
// Inspired by the 'Little Ouchies' fidget toy as featured by the
// YouTube channel "Slant 3d".
//
// This version implements the spikes in single for-loop, spiralling
// "organically". The default spiral angle is set to the Golden Angle,
// which will create a Fibonacci number count of sprials (depending on
// direction and angle which you count from).
// 
// Inspired by:
//   - Slant3D: https://youtu.be/KrHY6LNxY8Q
//   - Little Ouchies: https://littleouchies.com/
//   - Numberphile: https://youtu.be/sj8Sg8qnjOg
// 

// Customizer Variables

// Spirals are chiral, do you want right- or left-hand twist?
direction = 1; // [1:left-hand, -1:right-hand ]

// How long a thing you want to hold.
handle_length = 100; // [10:250] 
// How wide a thing you want to hold.
handle_middle_diameter = 40 ; // [10:1:150]
// How large are the ends?
handle_end_diameter = 20;// [10:1:150]
// Put a chamfer on the ends.
chamfer_size = 1; // [.01:5]

// A straight hole that runs down the middle, zero to disable.
hole_diameter = 0; // [0:150]

// more spikes = less pain
spike_count = 321; // [64:1024]
// How long to make the spikes?
spike_point_length = 3;  // [0:.1:5]
// Adjust to make sure spikes are attached to handle body.
backset_spikes = 2;  // [0:.01:5]
// What fraction of the length should be covered with spikes?
spike_coverage = .80; // [.10:.01: .90]

// golden angle = 137.507764
rotate_step = 137.507764; // angle

// How far do you want to push your printer's overhang?
allowed_overhang_angle = 30;  // [20:1:50]

// Spike resolution:
spike_fn = 24; 
// Handle resolution:
handle_fn_x = 48; 

// Calculations
// radii
handle_end_radius = handle_end_diameter / 2 -chamfer_size ; // distance
handle_middle_radius = handle_middle_diameter / 2 -chamfer_size ; // distance
swell_radius = handle_middle_radius - handle_end_radius;
swell = 2 * swell_radius;
hole_radius = hole_diameter /2 ;

// length accomadations
adjusted_length = handle_length - 2 * chamfer_size;// distance
spike_length = handle_length * spike_coverage; // distance
spike_length_radius = spike_length / 2; 
point_amplitude = backset_spikes + spike_point_length ; // distance

// trig solutions
little_h = adjusted_length / 2 ; // distance
phi = atan2 ( little_h , swell_radius  ); // angle
theta = 180 - 2 * phi ; // angle
big_r = little_h / sin(theta) ; // distance, radius of vertical curvature

ro = asin(spike_length_radius/big_r); // angle
spike_sweep = ro * 2; // angle
spike_step = spike_sweep / spike_count; // angle per spike
spike_max = ro; // angle
spike_min = -ro; // angle



module prototype_spike(){
    
    point_angle = allowed_overhang_angle + sign(swell) * spike_max; // angle
    triangle_spike_pts = [
        [ 0                                 ,  0                ],
        [ point_amplitude * tan(point_angle), -point_amplitude  ],
        [ 0                                 , -point_amplitude  ]
    ];
    translate([ spike_point_length, 0, 0 ])
    rotate([ 0, 90, 0 ])
    rotate_extrude( $fn = spike_fn)
    polygon( triangle_spike_pts );
}

module spikes(){
    for (p = [0 : 1 : spike_count ]) {
        rot = p * direction * rotate_step; 
        
        if (swell_radius != 0 ){
            // apple core & balloon
            a = spike_min  + spike_step *  p;
            offset_radius = big_r;
            rotate([ 0, 0, rot ])
            translate([ handle_middle_diameter/2, 0, 0 ])
            translate([ -offset_radius, 0, 0 ])
            rotate([ 0, a, 0 ])
            translate([ offset_radius, 0, 0 ])
            prototype_spike();
        }
        else{
            // Cylindrical
            h_step = - spike_length / spike_count;
            h_min =  spike_length_radius;
            h = h_min + p * h_step;
            rotate([ 0, 0, rot ])
            translate([ handle_middle_diameter/2, 0, h ])
            prototype_spike();
        }
    }
}


module handle(){
    
    debug_size = 1;
    
    // color("#00f")
    // translate([handle_end_diameter / 2, handle_length/2])
    // sphere(debug_size, $fn=24);
    
    // color("#0f0")
    // translate([handle_middle_diameter/2, handle_length/2])
    // sphere(debug_size, $fn=24);
    
    // color("#0f0")
    // translate([handle_middle_diameter/2, 0])
    // sphere(debug_size, $fn=24);
    
    chamfering_poly_points = [ 
        [ chamfer_size,  0            ], 
        [ 0,            -chamfer_size ], 
        [ 0,             chamfer_size ], 
    ];
    
    color("#f002")
    // rotate_extrude( angle = 360  )
    minkowski()
    {  // chamfer on ends of handle
        #color("#f00")
        polygon(chamfering_poly_points);
        
        #color("#0f04")
        if ( swell_radius < 0 ) {
            // apple core
            difference(){
                // color("#f004")
                translate([0,- adjusted_length/2 ])
                square(adjusted_length);
                
                // color("#00f4")
                translate([ handle_middle_radius - big_r, 0])
                circle( -big_r , $fa = .1 ); // high precision here to make up for small swell.
            }
        } 
        else {
            if (0 < swell_radius ) {
                // balloon
                intersection(){
                    // color("#f004")
                    translate( [ 0, -adjusted_length/2 ] )
                    square(adjusted_length);
                    
                    // color("#00f4")
                    translate([ handle_middle_radius - big_r, 0])
                    circle(big_r , $fa = .1 ); // high precision here to make up for small swell.
                } 
            } 
            else {
               // Cylindrical
               // color("#0f04")
               translate( [ 0, -adjusted_length/2 ] )
               square([ handle_end_radius , adjusted_length ]);
           }
       }
   }
}


module hole(){
    module hole_chamfer(){
        hole_chamfer_pts = [
        [chamfer_size*2,-hole_radius],
        [chamfer_size*2,chamfer_size*2],
        [0,0],
        [0,-hole_radius],
        ];
        // color("#0f0")
        translate([handle_length/2- chamfer_size, hole_radius  ])
        polygon(hole_chamfer_pts);
    }

    color("#88f")
    rotate_extrude() {
        rotate(90)
        union() {
            translate([-handle_length/2, 0])
            square([handle_length, hole_radius]);
            hole_chamfer();
            mirror([1,0])
            hole_chamfer();
        }
    }
}

difference() {
    union(){
        // color("#0f0")
        // spikes();
        // color("#f664")
        handle();
    }
    if (0 < hole_diameter ) { hole(); }
}

// translate([ handle_end_radius, 0, handle_length/2 ])
// rotate([ 0, allowed_overhang_angle, 0 ])
// color("#00f")
// cube(100);


