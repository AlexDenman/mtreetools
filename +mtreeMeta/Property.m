classdef Property < mtreeMeta.DeclaredVariable
    %% Properties
    properties (SetAccess = private)
        hasDefaultValue (1,1) logical = false
        defaultValue
        getAccess {mustBeA(getAccess,["string","char","cell"])} = "public"
        setAccess {mustBeA(setAccess,["string","char","cell"])} = "public"
        isDependent (1,1) logical = false
        isConstant (1,1) logical = false
        isAbstract (1,1) logical = false
        isTransient (1,1) logical = false
        isHidden (1,1) logical = false
        isGetObservable (1,1) logical = false
        isSetObservable (1,1) logical = false
        isAbortSet (1,1) logical = false
        isNonCopyable (1,1) logical = false
        hasGetMethod (1,1) logical = false
        getMethod mtreeMeta.FunctionDefinition {mustBeScalarOrEmpty}...
            = mtreeMeta.FunctionDefinition.empty
        hasSetMethod (1,1) logical = false
        setMethod mtreeMeta.FunctionDefinition {mustBeScalarOrEmpty}...
            = mtreeMeta.FunctionDefinition.empty
    end

    %% Methods -- set/get
    methods
        % ━━━━━━━━━━━━━━━━━━  getAccess  ━━━━━━━━━━━━━━━━━━━
        function set.getAccess(obj,newVal)
            newValIsText = isstring(newVal) || ischar(newVal);
            if newValIsText
                % Convert to string just in case the input is a character vector.
                newVal = string(newVal).strip;

                if ~isscalar(newVal)
                    error("mtreetools:Property:nonScalarGetAccess",...
                        "If ""getAccess"" is text, it must be a scalar string.");
                end
                
                validGetAccess = ["public","protected","private"];
                if ~ismember(newVal,validGetAccess)
                    validGetAccessBulletedList = join("• " + validGetAccess,newline);
                    error("mtreetools:Property:invalidGetAccessText",...
                        "If ""getAccess"" is text, it must be one of the following values:" +...
                        newline + validGetAccessBulletedList);
                end
            else
                % TODO: Validate getAccess cell array input (when GetAccess is equal to a list of
                % classes).
            end

            obj.getAccess = newVal;
        end
        % ━━━━━━━━━━━━━━━━━━  getAccess  ━━━━━━━━━━━━━━━━━━━

        % ━━━━━━━━━━━━━━━━━━  setAccess  ━━━━━━━━━━━━━━━━━━━
        function set.setAccess(obj,newVal)
            newValIsText = isstring(newVal) || ischar(newVal);
            if newValIsText
                % Convert to string just in case the input is a character vector.
                newVal = string(newVal).strip;

                if ~isscalar(newVal)
                    error("mtreetools:Property:nonScalarSetAccess",...
                        "If ""setAccess"" is text, it must be a scalar string.");
                end
                
                validSetAccess = ["public","protected","private","immutable"];
                if ~ismember(newVal,validSetAccess)
                    validSetAccessBulletedList = join("• " + validSetAccess,newline);
                    error("mtreetools:Property:invalidSetAccessText",...
                        "If ""setAccess"" is text, it must be one of the following values:" +...
                        newline + validSetAccessBulletedList);
                end
            else
                % TODO: Validate setAccess cell array input (when SetAccess is equal to a list of
                % classes).
            end

            obj.setAccess = newVal;
        end
        % ━━━━━━━━━━━━━━━━━━  setAccess  ━━━━━━━━━━━━━━━━━━━
    end
end