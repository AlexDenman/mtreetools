function file = findfile(A)
%%
arguments (Input)
	A
end
arguments (Output)
	file	string	{mustBeScalarOrEmpty,mustBeFileOrEmpty}
end
%% Determine name
assert(~isempty(A), "Empty input to findfile.")

if ischar(A)
	A=string(A);
end

if isstring(A) && endsWith(A,".m")
	file = which(A);
	return
end

switch class(A)
	case "string",		name = A;
	case "meta.class",	name = string(A.Name);
	case "meta.method",	name = string(A.DefiningClass.Name);
	otherwise
		if isobject(A),	name = string(metaclass(A).Name);
		else,			error(compose("Inputs of type %s to findfile are not supported.",class(A)))
		end
end

assert(numel(name)<=1, "Multiple names")

try
	executionContext = evalin('caller', 'matlab.internal.language.introspective.ExecutionContext.create');
catch
	executionContext = [];
end

res = struct;
[res.found, res.path, ~, res.err] = matlab.internal.language.introspective.resolveFile(name, executionContext);
if res.found && res.err==""
	file = res.path;
else
	file = string.empty;
end


end
%%
function mustBeFileOrEmpty(fpath)
	if ~isempty(fpath)
		mustBeFile(fpath)
	end
end