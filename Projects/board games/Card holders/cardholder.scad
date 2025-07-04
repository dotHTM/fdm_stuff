$fn = 60;

angle = 15; // [ 0 : 45 ]

wall_grip = 8; // [ 1 : .01 : 16 ]

wall_thick = 4; // [ 1 : .01 : 10 ]
gap_thick = 4; //  [ 1 : .01 : 10 ]
card_support = 40; // [ 1 : .01 : 100 ]
$champstfer = 0 ; // [0 : .01 : 8]

base = wall_thick / cos(angle);
layer_altitude_offset = card_support - wall_grip; 

back_altitude = layer_altitude_offset + card_support + wall_thick; 
backfoot = 5; // [ 0 : 0.01 : 50 ]
backfoot_altitude = 32; // [1 : 0.01 : 64]

z_beam = false;

offset_x = 0.01; // [ 0 : 0.01 : 120 ]
offset_y = 0.01; // [ 0 : 0.01 : 120 ]

offset = [offset_x, offset_y ,0.01 ];

length = 10; // [ 10 : 210 ] 

color("lime")
linear_extrude(length)
holder();


if (z_beam){
color("hotpink")
translate(offset)
linear_extrude(.5)
rotate(180)
holder();
}

module holder(){
//base
skewre( 3 * base + 2 * gap_thick, wall_thick , angle );

// first wall
skewre( base, wall_grip + wall_thick, angle );

// second wall
translate([ base + gap_thick ,0 ])
skewre( base, card_support + wall_thick, angle );

// raised floor
translate([1.5 * base + gap_thick ,0 ])
skewre( base + gap_thick, layer_altitude_offset + wall_thick , angle );

// // back wall
translate([ 2 * base + 2 * gap_thick ,0,0])
skewre( base, back_altitude, angle );

back_x = 2.5 * base + 2 * gap_thick;

ep_bf = backfoot + 0.5 * base;

// support back foot
translate( [  back_x , 0 ] )
intersection() {
    
        skewre( ep_bf, backfoot_altitude , angle );
        translate([-base/2,0,0])
        skewre( ep_bf, backfoot_altitude , -angle );
        
        translate([ep_bf, wall_thick])
        rotate(180 - angle)
        square(max(backfoot * base, backfoot_altitude));
}

// debug_sphere([ep_bf, wall_thick] + [  back_x , 0 ]);

module skewre( base, altitude, angle, $champstfer = $champstfer ){
    // A "square" skewed along it's base
    hypot = altitude / cos(angle);
    reach = hypot * sin(angle);
    
    c1 = $champstfer * sin(angle);
    c2 = $champstfer * cos(angle);
    
    polygon([
        [ c1, c2 ],
        // [ reach , altitude],
        [ reach - c1, altitude - c2],
        [ reach + $champstfer, altitude],
        
        // [ reach + base, altitude ],
        [ reach + base - $champstfer, altitude ],
        [ reach + base - c1 , altitude - c2],
        
        // [ base, 0 ],
        [ base + c1,  c2],
        [ base - $champstfer , 0 ],
        
        [ $champstfer, 0 ],
    ]);
}
}

module debug_sphere(location, size = 0.25, sp_color = "red"){
    color(sp_color)
    translate(location)
    sphere(size);
}