function [zTransVals] = fisherZ(rVals)
%% Do fisher z-transform on r-values

%%

zTransVals = 0.5*(log(1+rVals) - log(1-rVals));


end