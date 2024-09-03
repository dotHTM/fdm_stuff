
sqrt2 = sqrt(2);
sqrt3 = sqrt(3);

$epsilon_scale = 4;
epsilon = 10^( - $epsilon_scale);

practically_zero = 10^-8;

function pz( value, negative = false ) = value == 0 ? ( negative ? -practically_zero : practically_zero ) : value; 

function pass_positive(value) = value >= 0 ? value : 0;

function pass_positive_max(value, maximum) = if_positive(value<= maximum ? value : maximum );

function pass_between(value, low, high) = ( (low < high) ? (  (value < low) ? low : ( (high <= value) ? high : value ) ) : low  );

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

