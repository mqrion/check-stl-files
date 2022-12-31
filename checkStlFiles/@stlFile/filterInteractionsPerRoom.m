function bool = filterInteractionsPerRoom(obj, numberOfInteractionsPerRoom)
%FILTERINTERACTIONSPERROOM deletes files, that do no contain exactly
% numberOfInteractionsPerRoom interactions.
%   
% arguments:
%
%   numberOfInteractionsPerRoom     - number of interactions per room
bool = true;
if(obj.interactionsPerRoom~= numberOfInteractionsPerRoom)
    delete(sprintf('%s', obj.stlFilePath));
    %message = strcat("Deleting file ", obj.stlFilePath," because it has",int2str(obj.filterInteractionsPerRoom),"interactions");
    warning("Deleting file "+ obj.stlFilePath +" because it has "+ string(obj.interactionsPerRoom))
    bool = false;
    return
end

end

