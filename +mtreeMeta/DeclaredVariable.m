classdef (Abstract) DeclaredVariable < mtreeMeta.Metadata
    %% Properties
    properties (SetAccess = protected)
        hasSizeValidation (1,1) logical = false
        sizeValidation string {mustBeScalarOrEmpty} = string.empty
        hasClassValidation (1,1) logical = false
        classValidation string {mustBeScalarOrEmpty} = string.empty
        hasValidationFunctions (1,1) logical = false
        validationFunctions (1,:) string = string.empty
    end

    %% Methods -- set/get
    methods
        % ━━━━━━━━━━━━━━━━  sizeValidation  ━━━━━━━━━━━━━━━━
        function set.sizeValidation(obj,newVal)
            newVal = newVal.erase(whitespacePattern);
            if newVal == ""
                newVal = string.empty;
            end

            if ~isempty(newVal)
                containsExactlyOneParenthesesPair =...
                    newVal.count("(") == 1 && newVal.count(")") == 1;
                if ~containsExactlyOneParenthesesPair
                    error("mtreetools:DeclaredVariable:sizeValidationHasTooManyParentheses",...
                        "The size validation must have exactly one opening parthesis ""("" and "+...
                        "exactly one closing parenthesis "")"".")
                end
    
                isContainedWithinParenthesesPair = newVal.startsWith("(") && newVal.endsWith(")");
                if ~isContainedWithinParenthesesPair
                    error("mtreetools:DeclaredVariable:sizeValidationNotWithinParentheses",...
                        "The size validation must be contained withing a set of parentheses. "+...
                        "For example, ""(1,2)"".")
                end
                
                % The regex searches for any characters that aren't considered valid ("\d" is
                % numeric digits to represent the size, the colon represents "any size", and the
                % comma separates the size elements). To find if the string is ONLY valid
                % characters, we instead search if the string contains any characters that AREN'T
                % the valid characters. Enclosing the expression in "[]" matches any character in
                % the square brackets, and putting "^" at the start of the square brackets means
                % "match anything that's NOT in these brackets".
                sizeValidationContents = newVal.extractBetween("(",")");
                validCharacters = "\d:,";
                hasInvaidCharacters =...
                    ~isempty(regexp(sizeValidationContents,"[^"+validCharacters+"]","once"));
                if hasInvaidCharacters
                    error("mtreetools:DeclaredVariable:sizeValidationHasInvalidChracters",...
                        "The size validation must only contain numeric values, commas, and "+...
                        "colons (and parentheses to start and end the size validation).")
                end

                sizeValidationElements = sizeValidationContents.split(",");

                notEnoughElements = numel(sizeValidationElements) < 2;
                if notEnoughElements
                    error("mtreetools:DeclaredVariable:notEnoughSizeValidationElements",...
                        "The size validation must have at least 2 elements, separated by commas.");
                end

                hasBlankElements = any(sizeValidationElements == "");
                hasElementsWithMoreThanOneColon = any(sizeValidationElements.count(":") > 1);
                hasNumericElementsWithColon = any(sizeValidationElements.contains(digitsPattern)...
                    & sizeValidationElements.contains(":"));
                hasInvalidElements = hasBlankElements || hasElementsWithMoreThanOneColon...
                    || hasNumericElementsWithColon;
                if hasInvalidElements
                    error("mtreetools:DeclaredVariable:sizeValidationElementsInvalid",...
                        "Each size validation element must be either completely numeric or a "+...
                        "single colon, and all elements must be separated by exactly one comma.")
                end
            end

            obj.sizeValidation = newVal;
        end
        % ━━━━━━━━━━━━━━━━  sizeValidation  ━━━━━━━━━━━━━━━━

        % ━━━━━━━━━━━━━━━  classValidation  ━━━━━━━━━━━━━━━━
        function set.classValidation(obj,newVal)
            obj.classValidation = newVal.erase(whitespacePattern);
        end
        % ━━━━━━━━━━━━━━━  classValidation  ━━━━━━━━━━━━━━━━

        % ━━━━━━━━━━━━━  validationFunctions  ━━━━━━━━━━━━━━
        function set.validationFunctions(obj,newVal)
            obj.validationFunctions = newVal.erase(whitespacePattern);
        end
        % ━━━━━━━━━━━━━  validationFunctions  ━━━━━━━━━━━━━━
    end
end