function [val] = parse_validator(node)
%%
arguments (Input)
	node	mtree	{mustBeNodeKind(node,["DOT","ID","LP"])}
end
arguments (Output)
	val (1,1)	struct
end
import mtreetools.validators.*
%%

% initializing output struct
val = struct(...
	func = string(missing), ...
	str = string(node.tree2str) ...
	);
% 'str' field just holds string representation of validator, suitable
% for display even if you don't want to parse it any further.

val.inputs = cell(1,0);

if all(ismember(node.kinds,["DOT","FIELD","ID"])) 
	val.func = val.str;
	return
end


val.func = string(node.L.tree2str);

input = node.R;

num_val_inputs = mtreetools.pathlength(input,"X",includefirst=1);
val.inputs = cell(1,num_val_inputs);

for ii = 1:num_val_inputs
	% The code below sorts through the nodes contained in a given
	% validator.
	input_node_kinds = string(input.Tree.kinds);
	input_node_vals = string(input.Tree.stringvals);
	isvalue = ismember(input_node_kinds,...
		["ID","STRING","INT","DOUBLE","CHARVECTOR"]);
	val.inputs{ii} = reshape(input_node_vals(isvalue),1,[]);

	% Currently this will format the arguments to validation functions as
	% a vector of chars, strings, or double, depending on node kinds
	if all(ismember(input_node_kinds,["LB","ROW","CHARVECTOR"]))
		val.inputs{ii} = char(strjoin(val.inputs{ii},''));
	elseif any(ismember(input_node_kinds,["INT","DOUBLE"]))
		val.inputs{ii} = double(val.inputs{ii});
	end

	input = input.X; % Navigate to next validator input
	% validators are chained together such that each successive validator
	% is the last validator's "next" child.
end
%%
end