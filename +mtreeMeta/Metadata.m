classdef (Abstract) Metadata < handle
    %% Properties
    properties (SetAccess = protected)
        % Name of the metadata component.
        name (1,1) string = ""

        % Short description of the metadata component.
        description (1,1) string = ""

        % Detailed description of the metadata component.
        detailedDescription (1,1) string = ""
    end

    %% Methods -- set/get
    methods
        % ━━━━━━━━━━━━━━━━━━━━━  name  ━━━━━━━━━━━━━━━━━━━━━
        function set.name(obj,newVal)
            obj.name = strip(newVal);
        end
        % ━━━━━━━━━━━━━━━━━━━━━  name  ━━━━━━━━━━━━━━━━━━━━━

        % ━━━━━━━━━━━━━━━━━  description  ━━━━━━━━━━━━━━━━━━
        function set.description(obj,newVal)
            obj.description = strip(newVal);
        end
        % ━━━━━━━━━━━━━━━━━  description  ━━━━━━━━━━━━━━━━━━

        % ━━━━━━━━━━━━━  detailedDescription  ━━━━━━━━━━━━━━
        function set.detailedDescription(obj,newVal)
            obj.detailedDescription = strip(newVal);
        end
        % ━━━━━━━━━━━━━  detailedDescription  ━━━━━━━━━━━━━━
    end
end