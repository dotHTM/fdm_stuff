practically_zero = 0.000001;

function pz(value, negative = false) = value == 0 ? ( negative ? -practically_zero : practically_zero ) : value; 




xv = [ 1, 0, 0 ];
yv = [ 0, 1, 0 ];
zv = [ 0, 0, 1 ];
dv = [ 1, 1, 1 ];

