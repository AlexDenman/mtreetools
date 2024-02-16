function [arg] = parse_proptypedecl_node(node)
%%
arguments (Input)
	node	mtree	{mustBeNodeKind(node,"PROPTYPEDECL")}
end
arguments (Output)
	arg (1,1)	struct
end
import mtreetools.validators.*
%%

arg = struct(...
	argname		= string(node.VarName.stringval), ...
	fieldname	= string(node.VarNamedField.stringvals), ...
	classname	= string(node.VarNamedClass.stringvals), ...
	type		= string(node.VarType.stringvals) ...
	);

dim_nodes = node.R.R.L.Full;
arg.dims = double(string(dim_nodes.stringvals));
arg.dims(dim_nodes.kinds=="COLON") = Inf;

%% Validators
% This function doesn't parse the validators itself, that was getting too
% complex so I moved it out to parse_validator.
node = node.R.R.R.L;
if ~node.isempty
	num_validators = mtreetools.pathlength(node,"X",includefirst=1);
else
	num_validators = 0;
end


arg.validators = cell(1,num_validators);
for ii = 1:num_validators
	arg.validators{ii} = mtreetools.parse_validator(node);
	node = node.X;
end


%%
end