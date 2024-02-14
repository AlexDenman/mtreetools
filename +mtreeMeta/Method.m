classdef Method < mtreeMeta.Function
    %% Properties
    properties (SetAccess = private)
        access {mustBeA(access,["string","char","cell"])} = "public"
        isStatic (1,1) logical = false
        isAbstract (1,1) logical = false
        isSealed (1,1) logical = false
        isHidden (1,1) logical = false
    end

    %% Methods -- set/get
    methods
        % ━━━━━━━━━━━━━━━━━━━━  access  ━━━━━━━━━━━━━━━━━━━━
        function set.access(obj,newVal)
            newValIsText = isstring(newVal) || ischar(newVal);
            if newValIsText
                % Convert to string just in case the input is a character vector.
                newVal = string(newVal).strip;

                if ~isscalar(newVal)
                    error("mtreetools:Method:nonScalarAccess",...
                        "If ""access"" is text, it must be a scalar string.");
                end
                
                validGetAccess = ["public","protected","private"];
                if ~ismember(newVal,validGetAccess)
                    validGetAccessBulletedList = join("• " + validGetAccess,newline);
                    error("mtreetools:Method:invalidAccessText",...
                        "If ""access"" is text, it must be one of the following values:" +...
                        newline + validGetAccessBulletedList);
                end
            else
                % TODO: Validate access cell array input (when Access is equal to a list of
                % classes).
            end

            obj.access = newVal;
        end
        % ━━━━━━━━━━━━━━━━━━━━  access  ━━━━━━━━━━━━━━━━━━━━
    end
end