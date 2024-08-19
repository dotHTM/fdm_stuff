practically_zero = 0.000001;

function pz(value, negative = false) = value == 0 ? ( negative ? -practically_zero : practically_zero ) : value; 


