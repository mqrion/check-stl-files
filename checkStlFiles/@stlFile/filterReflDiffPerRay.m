function bool = filterReflDiffPerRay(obj,minRefl,maxRefl,minDiff,maxDiff)
%FILTERREFLDIFFPERRAY deletes files, that do not
% a number of reflections per ray between (including) minRefl and maxRefl,
% and a number of diffractions per ray between (including) minDiff and
% maxDiff
%
% It returns True, if the number of reflection(/diffractions) for all rays in the file 
% lies (including) between minRefl(/minDiff) and maxRefl(maxRefl)
%   
% arguments:
%
%   minRefl             - minimal number of reflections per ray
%   maxRefl             - maximal number of reflections per ray
%   minDiff             - minimal number of diffractions per ray
%   maxDiff             - maximal number of diffractions per ray
%
bool = true;
if(obj.minReflPerRay< minRefl || obj.maxReflPerRay > maxRefl || obj.minDiffPerRay < minDiff || obj.maxDiffPerRay > maxDiff)
    delete(sprintf('%s', obj.stlFilePath));
    warning("Deleting file "+ obj.stlFilePath)
    bool = false;
    return
end

end

