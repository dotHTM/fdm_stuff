use <spiral.scad>

wide = 1.8; 
tall = 1.8;
flat = 1.2;

pi = 3.14159;

inner_radius = 20;
outer_radius = 105;
pitch = wide + .2;

spiral_extrude(
    Radius= inner_radius, 
    EndRadius= outer_radius, 
    Pitch= pitch, 
    Height=0, 
    StepsPerRev=80, Starts=1)
{
    polygon(    [
        [  wide/2 , tall/2 ],
        [  flat/2 , tall   ],
        [ -flat/2 , tall   ],
        [ -wide/2 , tall/2 ],
        [ -flat/2 , 0      ],
        [  flat/2 , 0      ],
    ]);
};
