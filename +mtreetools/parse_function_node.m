function [func] = parse_function_node(node)
%%
arguments (Input)
	node	mtree	{mustBeNodeKind(node,["FUNCTION","PROTO"])}
end

arguments (Output)
	func	(1,1)	struct
end
import mtreetools.validators.*
%%

func.name = string(node.Fname.stringval);
func.input_names = reshape(string(node.Ins.Full.stringvals),1,[]);
func.output_names = reshape(string(node.Outs.Full.stringvals),1,[]);
func.is_prototype = node.iskind("PROTO");

%%
argblocks = node.L.X.Full.mtfind(Kind="ARGUMENTS");
if ~argblocks.isempty
	[func.input_arguments,func.output_arguments] = mtreetools.parse_arguments_nodes(argblocks,func.input_names);
else
	[func.input_arguments,func.output_arguments] = deal(struct.empty);
end

% %% Detect function type
% while ~node.isempty
% 	node = node.P;
% 	if node.iskind("METHODS")
% 		func.kind = "method";
% 	elseif node.iskind("FUNCTION")
% 		func.kind = "nested";
% 	elseif node.isempty
% 		func.kind = "top";
% 	end
% end


%%
end