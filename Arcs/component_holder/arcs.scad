$fn=30;
retention_fn = 20;

tolerance = .1; // [0.1, 0.2, 0.777]

wall_thickness = 2; // [ 1 : .1 : 4]
epsilon_scale = 10; // [0:8]

/* [bin dimensions] */

agents = "onside"; // ["upright", "onside"]

top_deck = 10; // [0 : .5 : 20]
wooden_bin_depth = 42; // [42 : 45]
rail_depth = 1; // [ 0 : .1: 1.4  ]

rail_support_offest = 2; // [0 : 0.2 : 3  ]

/* [delta params] */

delta_width =  30;
delta_altitude_short = 25;
delta_altitude_long = 30;

delta_thick = 2.2;
delta_step_long = 3;

/* [Lid version] */
mega = true; // [true, false]
closed_core = true; // [true, false]

/* [Show] */

// only on mega
show_card_lid = true; // [true, false]
show_lid = true; // [true, false]
show_body = true; // [true, false]

/* [Testing] */
test = false; // [true, false]
cut = false; // [true, false]
cut_x = 0; // [0: 200]
cut_y = 0; // [0: 200]
cut_z = 0; // [0: 50]

main();

module main(){
    if (test) {
        segmented_test();
    }
    else {
        difference() {
            union(){
                if (show_body){ body(); }
                if ( mega ){
                    if (show_lid){ mega_lid(); }
                    if (show_card_lid){ card_lid(); }
                }
                else{
                    if (show_lid){ core_lid( closed = closed_core ); }
                }

            }
            if (cut){
                translate(-5*dv) cube([cut_x,cut_y,cut_z]);
            }
        }
    }
}

wt2 = wall_thickness * 2;
wall_radius = wall_thickness/2;

sqrt2 = sqrt(2);

practically_zero = 10^-8;

$offset=0;
function pz(val, $offset=0) = (val == 0) ? practically_zero : val + $offset;

epsilon = 2^-epsilon_scale;

dv = [ 1, 1, 1 ];
xv = [ 1, 0, 0 ];
yv = [ 0, 1, 0 ];
zv = [ 0, 0, 1 ];

function dot_x(vect) = vect.x * xv;
function dot_y(vect) = vect.y * yv;
function dot_z(vect) = vect.z * zv;

function dot_xy(vect) = dot_x(vect) + dot_y(vect);
function dot_yz(vect) = dot_z(vect) + dot_y(vect);
function dot_zx(vect) = dot_x(vect) + dot_z(vect);

ship_bin = 32;
ship_bin_tall = 7;

agent_bin = agents == "upright" ? 12 : 20 ;
agent_bin_tall = agents == "upright" ? 11 : ship_bin_tall;
headroom = agents == "upright" ? 20 : 13 ;
max_height = headroom + wall_thickness;

rd_sq2 = sqrt2 * rail_depth;
lower_rail_height = wall_radius + rail_depth;

delta_altitude = agents == "upright" ? delta_altitude_short : delta_altitude_long;
delta_step = agents == "upright" ? delta_thick : delta_step_long;
stack=4;

delta_lid_offset = agents == "upright" ? 0 : wall_thickness + tolerance;

stack_thick = stack * delta_thick;
stack_step = stack * delta_step;
stack_back_tall = delta_altitude + stack_step;
stack_hypot = sqrt( stack_thick^2 + stack_back_tall^2 );

lean_back = -atan2(stack_back_tall, stack_thick);

stair_hyp = sqrt(stack_thick^2 + stack_step^2);
stair_depth = stair_hyp*sin(lean_back) ;
stair_height = delta_thick * 4 * sqrt2 * sin(lean_back + 45);
ship_bin_step = ship_bin + wall_thickness;
agent_bin_step = agent_bin + wall_thickness;
end_deep = wooden_bin_depth+wall_thickness;
end_width = 3*ship_bin_step+2*agent_bin_step+wall_thickness;

bin_offset =  delta_width+wall_thickness;
plate_deep = end_deep + bin_offset + wall_thickness;
delta_offset = end_width - wall_thickness - 2*stack_hypot  - wt2;

delta_box_height = 2 * abs(stair_height) + wall_thickness;

// lid interiors
lid_interior = [
end_width - 1 * wall_thickness + tolerance,
end_deep+bin_offset+wall_thickness + 2*tolerance,
max(headroom, delta_box_height) + wall_thickness + wall_thickness
];
// mega
mega_lid_interior = lid_interior + [ 0, 0,  top_deck + tolerance
];

lift = headroom + wall_thickness;

module segmented_test() {

    N = [40, 100, 100];

    translate(0 * xv)
    intersection() {
        translate(-10 * dv)
        cube(N);
        card_lid();
    }

    translate(50 * xv)
    intersection() {
        translate(-10 * dv)
        cube(N);
        mega_lid();
    }

    translate(100 * xv)
    intersection() {
        translate(-10 * dv)
        cube(N);
        core_lid();
    }

    translate(150 * xv)
    intersection() {
        translate(-10 * dv)
        cube(N);
        lid();
    }

    translate(200 * xv)
    intersection() {
        translate(-10 * dv)
        cube(N);
        body();
    }

}

module body(){
    // body

    difference()
    {
        color("lime")
        union() {

            // thick plate

            color("#e4ae56")
            rounded_box(
                [
                delta_offset - wall_thickness,
                bin_offset - wall_thickness,
                delta_box_height
                ]
                );

            //bins
            translate(bin_offset * yv) {
                color("#5c3749")
                rounded_box([ ship_bin, wooden_bin_depth, ship_bin_tall]);
                translate([ship_bin_step, 0, 0]){
                    color("#dd225a")
                    rounded_box([ ship_bin, wooden_bin_depth, ship_bin_tall]);
                }
                translate([2*ship_bin_step, 0, 0]){
                    color("#d2f2d9")
                    rounded_box([ ship_bin, wooden_bin_depth, ship_bin_tall]);
                }
                translate([3*ship_bin_step, 0, 0]){
                    color("#2328b2")
                    rounded_box([ agent_bin, wooden_bin_depth, agent_bin_tall]);
                }
                translate([3*ship_bin_step+agent_bin_step, 0, 0]){
                    color("#87f853")
                    rounded_box([ agent_bin, wooden_bin_depth, agent_bin_tall]);
                }
            }

            // delta bins
            translate(   ( delta_offset) * xv ) {
                translate([ 0, delta_width+2*wall_thickness, 0 ])
                rotate(-90*zv)
                delta_store();

                translate([ stack_hypot+wall_thickness, delta_width+2*wall_thickness, 0 ])
                rotate(-90*zv)
                delta_store();

            }
        }

        // rail slots
        union() {
            translate([0,0,lower_rail_height]) {
                rail();
                translate( (end_deep+bin_offset+wall_thickness) * yv)
                rail();
            }
        }
    }
}

module lid(){
    color("lightblue")
    core_lid(closed = true);
}

module core_lid(closed = false, delta_closed = false ){
  // lid
  color("pink")
  translate(-tolerance * xv)
  union() {
    lid_r2 = wall_radius + tolerance/2;

    //top

    // delta grip
    translate(- tolerance * yv)
    translate((wall_radius)*[-1,-1, 1])
    wall( dot_zx(lid_interior) - 2*wall_thickness*zv);

    // bin grip
    translate(dot_y(lid_interior)+(wall_thickness-tolerance)*yv)
    translate((wall_radius)*[-1,-1, 1])
    wall( dot_zx(lid_interior) - 2*wall_thickness*zv);

    // flat wall
    translate([- wall_radius ,
        -wall_radius-tolerance,
        wall_radius])
    wall([
        0,
        lid_interior.y   ,
        lid_interior.z - 2*wall_thickness
        ]);

    union() {
        // delta box top
        translate([
            lid_interior.x - 2 * agent_bin - 2 * wall_thickness,
            - wall_thickness - tolerance,
            delta_box_height +  wall_thickness
            + tolerance
            ]
            )
        rounded_box([
          2 * agent_bin + wall_thickness,
          delta_width + wall_thickness + tolerance + delta_lid_offset,
          lid_interior.z - delta_box_height - wall_thickness - tolerance  - wall_thickness
          ] ,
          closed = closed || delta_closed
          );

        // deck box top
        translate([
            - wall_thickness,
            - wall_thickness - tolerance,
            delta_box_height +  wall_thickness + tolerance
            ]
            )
        rounded_box([
          lid_interior.x - 2 * agent_bin - 2 * wall_thickness,

          (agents == "onside" ? delta_width + wall_thickness + tolerance + delta_lid_offset
            :

            lid_interior.y ),

          lid_interior.z - delta_box_height - wall_thickness - tolerance
          - wall_thickness
          ]
          ,
          closed = closed

          );

        // agent headroom box
        translate([
            (agents == "onside" ? - wall_thickness:
                lid_interior.x - 2 * agent_bin - 2 * wall_thickness
                ),
            bin_offset +delta_lid_offset,
            headroom + wall_thickness
            ])
        rounded_box(
            [

            (agents == "onside" ? lid_interior.x :
                2 * agent_bin + wall_thickness),
            lid_interior.y - (delta_width + 2* wall_thickness +  tolerance)-delta_lid_offset,
            lid_interior.z - headroom - wall_thickness - wall_thickness + (agents == "onside" ? tolerance : 0),
            ],
            closed = closed

            );
    }

    // ship bin rail support
    translate([
        - wall_thickness ,
        lid_interior.y +
        (-wall_thickness-tolerance),
        ship_bin_tall + wall_thickness + tolerance
        ])
    rounded_box( [
        3*ship_bin_step - wall_thickness,
        practically_zero,
        (headroom + wall_thickness) -
        (agent_bin_tall + wall_thickness + tolerance )
        ] , closed = true);

    // agent bin rail support
    translate([
        - wall_thickness ,
        lid_interior.y +
        (-wall_thickness-tolerance),
        agent_bin_tall + wall_thickness + tolerance
        ])
    rounded_box( [
        lid_interior.x ,
        practically_zero,
        (headroom + wall_thickness) -
        (agent_bin_tall + wall_thickness + tolerance )
        ] , closed = true);

    // back support
    translate([
        - wall_thickness ,
        bin_offset +delta_lid_offset + (agents == "onside" ? 0 : wall_thickness),
        ship_bin_tall + wall_thickness + tolerance
        ])
    rounded_box( [
        practically_zero,
        lid_interior.y - (delta_width + 2* wall_thickness +  tolerance)-delta_lid_offset - (agents == "onside" ? 0 : wall_thickness),
        (headroom + wall_thickness) -
        (agent_bin_tall + wall_thickness + tolerance )
        ] , closed = true);

    // lower rails
    union() {
        translate([0,0,lower_rail_height]) {

            rail_hull();

            translate([ 0, -tolerance, 0 ]) {
                rail(end_width - 3 * wall_radius );
            }

            translate( (end_deep+bin_offset+wall_thickness) * yv)
            translate([ 0, tolerance, 0 ]) {
                rail(end_width - 3 * wall_radius );
            }
        }
    }
}
}

module mega_lid(){

    color("hotpink")
    union() {
        // retention bump
        for (i = [wall_thickness]){
            for (j = [0]){
                translate([
                    i,
                    lid_interior.y/2,
                    mega_lid_interior.z + j - tolerance
                    ])
                scale([1 - 2* tolerance,3 - 1*tolerance, 2/3 ])
                sphere(wall_radius, $fn = retention_fn);
            }
        }
        core_lid(closed = agents == "onside" , delta_closed = true);

        translate(lift * zv)
        translate(-tolerance * xv)
        union() {
            lid_r2 = wall_radius + tolerance/2;

            // delta grip
            translate(- tolerance * yv)
            translate((wall_radius)*[-1,-1, 1])
            wall( dot_zx(mega_lid_interior)  + (  - lift - wall_thickness)*zv);

            // bin grip
            translate(dot_y(mega_lid_interior)+(wall_thickness-tolerance)*yv)
            translate((wall_radius)*[-1,-1, 1])
            wall( dot_zx(mega_lid_interior)  + (  - lift - wall_thickness)*zv);

            // flat wall
            translate([- wall_radius ,
                -wall_radius-tolerance,
                wall_radius
                ])

            wall([
                0,
                mega_lid_interior.y   ,
                mega_lid_interior.z - wall_thickness - lift

                ]);

            union() {

                // deck box top
                deck_translate = [
                - wall_thickness,
                - wall_thickness - tolerance,
                delta_box_height +  wall_thickness + tolerance - lift
                ];
                deck_interior = [
                mega_lid_interior.x - 2 * agent_bin - 2 * wall_thickness,
                mega_lid_interior.y,
                mega_lid_interior.z - delta_box_height - wall_thickness - tolerance
                - wall_thickness - tolerance
                ];

                // card lid Support

                front_lift = max(delta_box_height , headroom);

                // front support
                translate([
                    lid_interior.x - wall_thickness,
                    - wall_thickness - tolerance,
                    front_lift +  wall_thickness
                    + tolerance - lift
                    ]
                    )
                rounded_box([
                  practically_zero,
                  lid_interior.y,
                  mega_lid_interior.z - front_lift - wall_thickness - tolerance  - wall_thickness - tolerance
                  ], closed = true );

                // delta
                translate(deck_translate)
                rounded_box(
                    [
                    lid_interior.x,
                    pz(rail_support_offest),
                    deck_interior.z
                    ]
                    , closed = true );

                // agent
                translate(deck_translate + (deck_interior.y - rail_support_offest)* yv)
                rounded_box(
                    [
                    lid_interior.x,
                    pz(rail_support_offest),
                    deck_interior.z
                    ]

                    ,
                    closed = true );

                // back
                translate(deck_translate)
                rounded_box(
                    dot_yz(deck_interior) + pz(rail_support_offest) *xv,
                    closed = true );

            }

            // upper rails
            union() {

              translate((mega_lid_interior.z + wall_radius - lift)*zv)
              rail_hull();

              translate([ 0, 0, mega_lid_interior.z + wall_radius - lift]) {
                translate(- tolerance * yv){
                    intersection() {
                        cube( wall_thickness * [end_width,2,1], center=true);
                        union(){
                            translate( [ - wall_radius, - wall_radius , 0 ])
                            cube([end_width - wall_thickness , wall_radius , rail_depth ]);
                            translate( - wall_radius * xv )
                            rail(end_width - wall_thickness );
                        }
                    }
                }

                translate( mega_lid_interior.y*yv)
                translate(- tolerance * yv){
                    intersection() {
                        cube( wall_thickness * [end_width,2,1], center=true);
                        union(){
                            translate( [ - wall_radius, 0 , 0 ])
                            cube([end_width - wall_thickness , wall_radius , rail_depth ]);
                            translate( - wall_radius * xv )
                            rail(end_width - wall_thickness );
                        }
                    }
                }
            }
        }

    }
}
}

module card_lid(){
    // card lid
    color("#ddd9")
    difference() {

        union() {

            // main
            translate([ wall_radius, 0, mega_lid_interior.z ])
            cube([
                mega_lid_interior.x - tolerance,
                mega_lid_interior.y - 2* tolerance,
                wall_thickness
                ]);

            // flat end
            translate([ wall_radius, 0, mega_lid_interior.z  + wall_radius ])
            rotate(-90*xv)
            cylinder( lid_interior.y - 2 * tolerance, wall_radius, wall_radius);

            // agent end
            translate([ wall_radius + mega_lid_interior.x- tolerance, 0, mega_lid_interior.z  + wall_radius ])
            rotate(-90*xv)
            cylinder( lid_interior.y - 2 * tolerance, wall_radius, wall_radius);

        }

        // upper rails
        translate([0,0,mega_lid_interior.z + wall_radius ]) {
            
            translate( [ - wall_radius ,+ tolerance,0 ] ){
                rail( end_width + 2 * wall_thickness);
                translate([ 0, -rail_depth + 2 * tolerance, - rail_depth - epsilon])
                cube([ end_width + 2 * wall_thickness , rail_depth , 2 * ( rail_depth  + epsilon )]);
            }
            
            translate( (mega_lid_interior.y - 3 * tolerance) * yv )
            translate( - wall_radius * xv )
            {
            
            rail( end_width + 2 * wall_thickness);
            translate([ 0, - 2 * tolerance , - rail_depth - epsilon])
                cube([ end_width + 2 * wall_thickness , rail_depth , 2 * ( rail_depth + epsilon)]);
            }
            
            
                

        }


        // retention and thumb grips
        for (i = [wall_thickness, lid_interior.x]){
            for (j = [0 , wall_thickness]){
                for (k = ( lid_interior.y/2 - 2.5 * wall_thickness) * [ -1, 0, 1]){
                    for ( t = [ 0 : 1.5 * wall_thickness : ( k == 0 ? 0 : 20 ) ]){
                    translate([
                        i + ( i != wall_thickness  ? -1: 1) * t,
                        lid_interior.y/2 + k,
                        mega_lid_interior.z + j
                        ])
                    scale([1,3,2/3])
                    sphere(wall_radius, $fn = retention_fn);
                    }
                }
            }
        }

    }
}

module rail(length = end_width + 2 * epsilon ){
    union(){
        rotate([45,0,0])
        translate([length/2,0,0])
        cube([length,rd_sq2,rd_sq2], center = true);

        rail_endcap();
        translate([length,0,0])
        rail_endcap();
    }
}

module rail_endcap(){
    rotate_extrude()
    intersection() {
        translate(rail_depth * xv)
        square(2*rail_depth, center = true);
        rotate(45)
        square(rd_sq2, center= true);
    }
}

module interior_fillet (r1, r2, angle = 90){

    intersection() {
        rotate(90*yv)
        cube(
            2*(r1 + r2),
            center=true
            );

        rotate([90,0,90])
        rotate_extrude(angle = angle)
        translate((r1 + r2) *xv)
        union(){
            circle(r1);
            translate([r1,0])
            square([
                2*r1,
                2*r1,
                ],
                center=true
                );
        }
    }
}

module  delta_store(){
    working_width = delta_width+2*epsilon;
    inner_dim = [
    delta_width,
    stack_hypot,
    delta_box_height
    ];

    union() {

        translate(wall_thickness * dv)
        intersection() {
            translate ([-epsilon,0, - stair_height ])
            rotate( [lean_back,0,0] ){
                color("#f82ec9")
                for (i = [1:1:stack]){
                    translate([0,delta_thick*(i-1),0])
                    scale([1,1,i])
                    translate([0,0,-delta_step])
                    cube([working_width,delta_thick ,2*delta_step]);
                }
                // stack back
                color("#24def2")
                translate([0,stack_thick,0])cube([ working_width, delta_thick*stack, stack_back_tall ]);
            }
            // clip box
            color("#224e25")
            translate(-epsilon * dv)
            cube( inner_dim  + 2 * epsilon * dv);
        }

        color("#00ff00")
        rounded_box(  inner_dim  );
    }
}

module wall(inside_dim, radius = wall_radius){
    minkowski() {
        cube([ pz(inside_dim.x, wall_thickness), pz(inside_dim.y, wall_thickness), pz(inside_dim.z, wall_thickness) ]);
        sphere(radius);
    }
};
module rounded_box( inside_dim , closed = false, bottomed = true){
    if (closed){

        translate( 1.5* wall_radius * dv )
        cube(
            inside_dim + ( wall_radius )  * dv - wall_radius * zv);
    }

    translate(wall_radius * [1,1,1])
    {
        union() {
            if (bottomed)
            {
                // xy, bottom
                wall([inside_dim.x,inside_dim.y,0]);
            }
            // xz
            wall([inside_dim.x,0,inside_dim.z-wall_thickness]);
            // yz
            wall([0,inside_dim.y,inside_dim.z-wall_thickness]);
            // xz, opposite
            translate([0,inside_dim.y+wall_thickness,0 ]){
                wall([inside_dim.x,0,inside_dim.z-wall_thickness]);
            }
            // yz, opposite
            translate([inside_dim.x+wall_thickness,0,0]){
                wall([0,inside_dim.y,inside_dim.z-wall_thickness]);
            }
            // xy, top
            if (closed){
                wall([inside_dim.x,inside_dim.y,inside_dim.z-wall_thickness]);
            }
        }
    }
}

module rail_hull(){
 translate([
    mega_lid_interior.x - wall_radius - tolerance,
    0 - tolerance,
    0,
    ])
 {
    hull() {

        rail_endcap();
        translate([
            tolerance + wall_thickness,
            -wall_radius ,
            0
            ])
        sphere(wall_radius);
        translate([
            - tolerance,
            -wall_radius ,
            0
            ])
        sphere(wall_radius);
    }

    translate([
        0,
        lid_interior.y ,
        0
        ])
    hull() {

        rail_endcap();
        translate([
            tolerance + wall_thickness,
            wall_radius,
            0
            ])
        sphere(wall_radius);

        translate([
            - tolerance,
            wall_radius,
            0
            ])
        sphere(wall_radius);
    }
}
}