classdef stlFile
    %STLFILE
    % contains information abou the stl-file, that come from raytracing
    % like number of reflections, diffractions ..


    properties
        % grid resolution
        GRID_RESOLUTION = 100;

        % step size in grid (cm)
        GRID_STEP_SIZE = 10;


        % full path of the stl-file
        stlFilePath

        %% Refl/Diff per Room
        % number of reflections in a room
        reflPerRoom {mustBeNumeric}
        % number of diffractions in a room
        diffPerRoom {mustBeNumeric}
        % interactions per room
        interactionsPerRoom {mustBeNumeric}


        %% Refl/Diff per Ray
        % maximal reflections per ray
        maxReflPerRay {mustBeNumeric}
        % maximal diffraction per ray
        maxDiffPerRay {mustBeNumeric}

        % minimal reflections per ray
        minReflPerRay {mustBeNumeric}
        % minimal diffractions per ray
        minDiffPerRay {mustBeNumeric}

        %% interactions per room and ray
        % maximal interactions per ray
        maxInteractionsPerRay {mustBeNumeric}
        % minimal interactions per ray
        minInteractionsPerRay {mustBeNumeric}

        % containing reflections
        reflMatrix
        % containing diffractions
        diffMatrix

    end

    methods
        function obj = stlFile(stlFilePath, RX, TX, RT_PARAMETER,roomSize)
            %STLFILE
            %   setting all the properties
            obj.stlFilePath     = stlFilePath;
            rInfo               = obj.rayTracingInfo(stlFilePath, RX, TX, RT_PARAMETER);

            obj.GRID_STEP_SIZE  = obj.GRID_RESOLUTION/roomSize;

            obj.reflPerRoom     = 0;
            obj.diffPerRoom     = 0;
            obj.interactionsPerRoom = 0;

            obj.maxReflPerRay   = 0;
            obj.maxDiffPerRay   = 0;
            obj.maxInteractionsPerRay = 0;

            obj.minReflPerRay   = 0;
            obj.minDiffPerRay   = 0;
            obj.minInteractionsPerRay = 0;

            obj.reflMatrix      = zeros(obj.GRID_RESOLUTION);
            obj.diffMatrix      = zeros(obj.GRID_RESOLUTION);

            for r=1:length(rInfo)
                for k=1:length(rInfo{1,r}) % each ray
                    tempReflPerRay          = 0;
                    tempDiffPerRay          = 0;
                    tempInteractionsPerRay  = rInfo{1,r}(k).NumInteractions;
                    obj.interactionsPerRoom = obj.interactionsPerRoom + tempInteractionsPerRay;
                    for i=1:length(rInfo{1,r}(k).Interactions) % each interaction per ray
                        type = rInfo{1,r}(k).Interactions(i).Type;
                        if ( type == "Reflection" && ~rInfo{1,r}(k).LineOfSight)
                            obj.reflPerRoom         = obj.reflPerRoom +1;
                            tempReflPerRay          = tempReflPerRay +1;

                            position                = rInfo{1,1}(k).Interactions(i).Location;
                            x                       = ceil(position(1,1)*obj.GRID_STEP_SIZE);
                            y                       = ceil(position(2,1)*obj.GRID_STEP_SIZE);
                            obj.reflMatrix(x,y)     = obj.reflMatrix(x,y)+1;
                        elseif (~rInfo{1,1}(k).LineOfSight && type=="Diffraction")
                            obj.diffPerRoom         = obj.diffPerRoom +1;
                            tempDiffPerRay          = tempDiffPerRay +1;

                            position                = rInfo{1,1}(k).Interactions(i).Location;
                            x                       = ceil(position(1,1)*obj.GRID_STEP_SIZE);
                            y                       = ceil(position(2,1)*obj.GRID_STEP_SIZE);
                            obj.diffMatrix(x,y)     = obj.diffMatrix(x,y)+1;
                        end
                    end
                    if(tempReflPerRay<obj.minReflPerRay)
                        obj.minReflPerRay = tempReflPerRay;
                    end
                    if(tempReflPerRay>obj.maxReflPerRay)
                        obj.maxReflPerRay = tempReflPerRay;
                    end
                    if(tempDiffPerRay<obj.minDiffPerRay)
                        obj.minDiffPerRay = tempDiffPerRay;
                    end
                    if(tempDiffPerRay>obj.maxDiffPerRay)
                        obj.maxDiffPerRay = tempDiffPerRay;
                    end
                    if(tempInteractionsPerRay<obj.minInteractionsPerRay)
                        obj.minInteractionsPerRay = tempInteractionsPerRay;
                    end
                    if(tempInteractionsPerRay>obj.maxInteractionsPerRay)
                        obj.maxInteractionsPerRay = tempInteractionsPerRay;
                    end
                end
            end
        end
    end

    methods(Access=private)
        function rayTracing = rayTracingInfo(obj, stlFilePath, RX, TX, RT_PARAMETER)
            % performing basic raytracing
            %% raytracing for raytracing info
            isoAntenna = phased.IsotropicAntennaElement; % some antenna

            tx = txsite("cartesian", ...
                "Antenna",isoAntenna, ...
                "AntennaPosition",TX, ...
                'TransmitterFrequency',60e9);

            rx = rxsite("cartesian", ...
                "Antenna",isoAntenna, ...
                "AntennaPosition",RX);

            pm = propagationModel("raytracing", ...
                "Method","sbr",...
                "AngularSeparation", RT_PARAMETER('AngularSeparation'),...
                "CoordinateSystem","cartesian", ...
                "SurfaceMaterial", RT_PARAMETER('SurfaceMaterial'),...
                "MaxNumReflections", str2double(RT_PARAMETER('MaxNumReflections')),...
                "MaxNumDiffractions",str2double(RT_PARAMETER('MaxNumDiffractions')));

            rayTracing          = raytrace(tx,rx,pm,'Map',stlFilePath);
        end
    end
end

