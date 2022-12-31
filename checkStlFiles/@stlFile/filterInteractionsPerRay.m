function bool = filterInteractionsPerRay(obj,minInteractions, maxInteractions)
%FILTERINTERACTIONSPERROOM deletes files, that do not have between
% minInteractions and maxInteractions interactions.
% It returns True, if the number of interactions for all rays in the file 
% lies (including) between minInteractions and maxInteractions.
%   
% arguments:
%
%   minInteractions         - minimal number of interactions per ray
%   maxInteractions         - maximal number of interactions per ray
%
bool = true;
if(obj.minInteractionsPerRay< minInteractions || obj.maxInteractionsPerRay>maxInteractions)
    delete(sprintf('%s', obj.stlFilePath));
    warning("Deleting file "+ obj.stlFilePath)
    bool = false;
    return
end

end

