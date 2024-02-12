function [funcName,funcInputs,funcOutputs,funcType] = parse_function_node(node)
%%
arguments (Input)
	node	mtree	{mtreetools.mustBeNodeKind(node,"FUNCTION")}
end

arguments (Output)
	funcName	(1,1)	string
	funcInputs	(1,:)	string
	funcOutputs	(1,:)	string
	funcType	(1,1)	string
end
%%

funcName = string(node.Fname.stringval);
funcInputs = string(node.Ins.Full.stringvals);
funcOutputs = string(node.Outs.Full.stringvals);


while ~node.isempty
	node = node.Parent;
	if node.iskind("METHODS")
		funcType = "method";
	elseif node.iskind("FUNCTION")
		funcType = "nested";
	elseif node.isempty
		funcType = "top";
	end
end


%%
end