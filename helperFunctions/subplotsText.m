function [varargout] = subText(x, y, xLims, yLims, textStr)
%% This function uses 'text' but places the tex at the same position for all subplots
    % 'x, y' - relative x and y positions on [0 1] limits where text will be placed
          % (0,0) is bottom left corner
          % eg. (1.1, 1.1) places text above and to the right of the top right corner of the current plot axes
    % 'xLims, yLims' - the xlim and ylim of the current axes
    
    
newX = interp1([0,1], xLims, x, 'linear', 'extrap');
newY = interp1([0,1], yLims, y, 'linear', 'extrap');

varargout{1} = text(newX, newY, textStr);

varargout{2} = newX;
varargout{3} = newY;


end