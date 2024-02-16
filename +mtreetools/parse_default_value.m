function [default] = parse_default_value(defnode,varnames)
%% In: default value node (R of argument or property node); out: struct (field 'kind' = "none" if no default)
arguments (Input)
	defnode		mtree	{mustBeSingleNodeOrEmpty}
	varnames	(:,1)	string
end
arguments (Output)
	default		(1,1)	struct
end
import mtreetools.validators.*

%% Return early or initialize output struct

if defnode.isempty
	default = struct(kind="none");
	return
else
	default = struct(kind=missing,str = string(defnode.tree2str));
end

%% Detect what variables, if any, are used in the default value expression

if ~isempty(varnames)
	ids_in_default = string(defnode.Tree.mtfind(Kind="ID").stringvals);
	default.depends_on = intersect(varnames,ids_in_default);
else
	default.depends_on = strings(1,0);
end

default.expression = str2func(compose("@(%s) %s", strjoin(default.depends_on,","), default.str));

%% Determine type of expression
if ~isempty(default.depends_on)
	default.kind = "dependent";
elseif false %TODO: Set conditions for considering a default expression to be too complex to evaluate
	default.kind = "complex";
else
	default.kind = "simple";
end

%% If default has simple value, evaluate the expression

if default.kind == "simple"
	default.value = default.expression();
	default.hasvalue = true;
else
	default.hasvalue = false;
end



%%
end