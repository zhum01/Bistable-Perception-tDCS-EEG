function [ nearestDecimal ] = round5(number, decToRoundTo, floorOrCeil)
% This function rounds to the nearest multiple that is given as the second
% input argument. Eg. round5(1.2,.5) rounds 1.2 to the nearest .5, which
% is 1.

remainder = mod(number, decToRoundTo);

% decToRoundTo/2 gets the halfway point (i.e. the critical point for rounding) 
% between the lower and upper multiple of decToRoundTo 
% if the remainder is greater than the critical point (or if ceiling option is used), round up
if ~strcmp(floorOrCeil, 'floor') && (any(remainder >= decToRoundTo/2) || strcmp(floorOrCeil, 'ceil'))
    nearestDecimal = number + (decToRoundTo - remainder);
% if the remainder is lower than the critical point (or floor), round down
elseif any(remainder < decToRoundTo/2) || strcmp(floorOrCeil, 'floor')
    nearestDecimal = number - remainder;
end

end

