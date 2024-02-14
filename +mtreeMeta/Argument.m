classdef (Abstract) Argument < mtreeMeta.DeclaredVariable
    %% Properties
    properties (SetAccess = private)
        isRequired (1,1) logical = false
        isIgnored (1,1) logical = false
        isRepeating (1,1) logical = false
    end
end