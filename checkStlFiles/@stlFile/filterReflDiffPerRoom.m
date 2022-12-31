function bool = filterReflDiffPerRoom(obj,numberReflectionPerRoom,numberDiffractionPerRoom)
%FILTERREFLDIFFPERROOM deletes files, that do no contain exactly
% numberReflectionPerRoom reflections or numberDiffractionsPerRoom
% diffractions
%   
% arguments:
%
%   numberReflectionsPerRoom     - number of reflections per room
%   numberDiffractionsPerRoom    - number of diffractions per room
bool = true;
if(obj.reflPerRoom~= numberReflectionPerRoom || obj.diffPerRoom ~= numberDiffractionPerRoom)
    delete(sprintf('%s', obj.stlFilePath));
    warning("Deleting file "+ obj.stlFilePath)
    bool = false;
    return
end

end

