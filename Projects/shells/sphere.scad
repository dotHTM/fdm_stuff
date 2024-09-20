
$fn = 60;

r_min = 10; 
gap = 2;
thickness = 2; 
r_max = 50 ; 
plate_thickness = 10;




module shell(n, o, h = plate_thickness){
 union() {
     semi(n, o, h);
     scale([1,1,-1])
     semi(n, o, h);
 }   
}

module semi(n, o, h){
   difference() {
    translate([0,0,0.01])
    coney(n + o,o,h);
    coney(n,o, h + 0.02);
}
}
module coney(n, o, h){
 angle = 30;
 cylinder(
    h * cos(angle),
    n + o,
    n + o - h * sin(angle)
    );
}



for (r = [r_min : gap + thickness : r_max]) {
    shell(r, thickness);
}