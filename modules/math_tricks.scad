
$epsilon_scale = 4;
epsilon = 10^( - $epsilon_scale);

practically_zero = 10^-8;

function pz( value, negative = false ) = value == 0 ? ( negative ? -practically_zero : practically_zero ) : value; 

// quick vectors
xv = [ 1, 0, 0 ];
yv = [ 0, 1, 0 ];
zv = [ 0, 0, 1 ];

xyv = [ 1, 1, 0 ];
yzv = [ 0, 1, 1 ];
zxv = [ 1, 0, 1 ];

dv = [ 1, 1, 1 ];

function iv(scalar)  = scalar * xv   ;
function jv(scalar)  = scalar * yv   ;
function kv(scalar)  = scalar * zv   ;
function ijv(scalar) = scalar * xyv  ;
function jkv(scalar) = scalar * yzv  ;
function kiv(scalar) = scalar * zxv  ;
function ijkv(scalar)  = scalar * dv ;

