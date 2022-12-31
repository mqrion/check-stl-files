function reflectionCountingMatrix = filterFolderRefl(DATA_PATH,IMAGEPATH,DATASETNAME,THRESHOLD_FOR_REFL,INTERACTIONS)
%FILTERFOLDERREFL loops through all stl-files in DATA_PATH
%   and deletes the files, that don't show the desired properties.
%
%
%   THRESHOLD_FOR_REFL specifies the maximal number of reflection per grid-quadrant
%   INTERACTIONS specifies the exact number of interactions (reflections due to setup)
%   IMAGEPATH specifies the path to save the images
%   DATASETNAME will be used as the name for saving


%% CONSTANT VAVLUES
MAXREFLECTIONSPERRAY        = 1;
MAXDIFFRACTIONPERRAY        = 0;
RAYTRACE_PARAMETER          = containers.Map({'MaxNumReflections','MaxNumDiffractions','AngularSeparation','SurfaceMaterial'},[MAXREFLECTIONSPERRAY,MAXDIFFRACTIONPERRAY,"low","metal"]);

% Simulation Setup
Z_VALUE                     = 1;                               % value for z
TX                          = [5; 2.25;Z_VALUE];               % position tx
RX                          = [5; 7.75;Z_VALUE];               % position rx
ROOM_SIZE                   = 10;


% counting the reflection per position
reflectionCountingMatrix    = zeros(100);


% all stl-files of dataset
files                       = dir(strcat(DATA_PATH,"*.stl"));
fileCntr                    = 1;
lfiles                      = length(files);

% file loop
for file    = files'
    if   mod(fileCntr, ceil(lfiles/10)) == 0 || fileCntr == lfiles       % output
        fprintf('%3.0f%% of the CSV-file is ready \n',fileCntr/lfiles*100);
    end
    try
        room = stlFile(strcat(file.folder,"/", file.name), RX, TX,RAYTRACE_PARAMETER, ROOM_SIZE);
        fileCntr = fileCntr +1;

        % checking the number of interactions per room
        if(room.filterInteractionsPerRoom(INTERACTIONS))

            tempMatrix = reflectionCountingMatrix + room.reflMatrix;

            % checking the threshold for reflection is violated
            if(ismember(1,(tempMatrix>THRESHOLD_FOR_REFL)))
                warning("Deleting file "+ file.name)
                delete(sprintf('%s', strcat(file.folder,"/", file.name)));
            else
                reflectionCountingMatrix = tempMatrix;
            end
        end

    catch ME
        fprintf(1, "Error: \n%s ", ME.message);
        warning("Deleting file "+ file.name);
        delete(sprintf('%s', strcat(file.folder,"/", file.name)));
    end

end

% saving an image of the reflection matrix
testImage = imagesc(reflectionCountingMatrix);
axis equal;
colorbar;
title(DATASETNAME);
saveas(testImage,IMAGEPATH+"countingReflections_"+DATASETNAME+".jpg");

end

