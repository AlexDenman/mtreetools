function [input_args, output_args] = parse_arguments_nodes(argblocks,varnames)
%%
arguments (Input)
	argblocks	mtree	{mustBeNodeKind(argblocks,"ARGUMENTS")}
	varnames	(:,1)	string
end
arguments (Output)
	input_args	(1,:)	struct
	output_args	(1,:)	struct
end
import mtreetools.validators.*
%%
num_args = argblocks.Tree.mtfind(Kind="ARGUMENT").count;
args = cell(num_args,2);

argnum = 1;
for ii = argblocks.indices
	block = argblocks.select(ii);
	is_input = ~block.L.Full.anystring("Output");
	is_repeating = block.L.Full.anystring("Repeating");

	arg = block.R;
	while ~arg.isempty
		if arg.iskind("ARGUMENT")
			current_arg = struct(...
				is_repeating = is_repeating, ...
				definition = mtreetools.parse_proptypedecl_node(arg.L), ...				
				default = mtreetools.parse_default_value(arg.R,varnames) ...
				);	
			if is_input
				args{argnum,1} = current_arg;
			else
				args{argnum,2} = current_arg;
			end
			argnum = argnum+1;
		end
		arg = arg.X;
	end
end

input_args = vertcat(args{:,1}).';
output_args = vertcat(args{:,2}).';




%%
end