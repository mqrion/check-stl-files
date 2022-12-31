function bool = filterLessInteractionsPerRoom(obj, numberOfInteractionsPerRoom)
%FILTERINTERACTIONSPERROOM deletes files, that do no contain less then or
% equal to
% numberOfInteractionsPerRoom interactions.
%   
% arguments:
%
%   numberOfInteractionsPerRoom     - number of interactions per room
bool = true;
if(obj.interactionsPerRoom > numberOfInteractionsPerRoom)
    delete(sprintf('%s', obj.stlFilePath));
    warning("Deleting file "+ obj.stlFilePath)
    bool = false;
    return
end

end

