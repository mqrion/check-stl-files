function bool = filterMoreInteractionsPerRoom(obj, numberOfInteractionsPerRoom)
%FILTERINTERACTIONSPERROOM deletes files, that do no contain more then
% equal to
% numberOfInteractionsPerRoom interactions.
%   
% arguments:
%
%   numberOfInteractionsPerRoom     - number of interactions per room
bool = true;
if(obj.interactionsPerRoom < numberOfInteractionsPerRoom)
    delete(sprintf('%s', obj.stlFilePath));
    warning("Deleting file "+ obj.stlFilePath)
    bool = false;
    return
end

end

