function [vars] = load_cmap_vars(cmapFName, vars)
%%

%%
loadDir = ['/isilon/LFMI/VMdrive/Mike/custom_functions/'];

load([loadDir cmapFName])

vars.cmap = eval(cmapFName);
    

end