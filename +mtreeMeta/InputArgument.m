classdef InputArgument < mtreeMeta.Argument
    %% Properties
    properties
        hasDefaultValue (1,1) logical = false
        defaultValue
        isNameValue (1,1) logical = false
        nameValueParentStructureName string {mustBeScalarOrEmpty} = string.empty
        isNameValueFromClassProperties (1,1) logical = false
    end

    %% Methods -- set/get
    methods
        % ━━━━━━━━━  nameValueParentStructureName  ━━━━━━━━━
        function set.nameValueParentStructureName(obj,newVal)
            obj.nameValueParentStructureName = newVal.erase(whitespacePattern);
        end
        % ━━━━━━━━━  nameValueParentStructureName  ━━━━━━━━━
    end
end