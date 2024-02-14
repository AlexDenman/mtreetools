classdef Function < mtreeMeta.Metadata
    %% Properties
    properties (SetAccess = protected)
        Inputs (1,:) mtreeMeta.InputArgument = mtreeMeta.InputArgument.empty
        Outputs (1,:) mtreeMeta.OutputArgument = mtreeMeta.OutputArgument.empty
        type (1,1) string {mustBeMember(type,["standalone","local","nested","method"])}...
            = "standalone"
    end
end